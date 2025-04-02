import 'package:agman/features/materiales/data/models/materialmodelrequest.dart';
import 'package:agman/features/materiales/data/models/materialmovemodelrequest.dart';
import 'package:agman/features/materiales/data/repos/materialrepoimp.dart';
import 'package:bloc/bloc.dart';

import '../../../data/models/materialmodel/datum.dart';
import '../../../data/models/materialmoves/datum.dart';

part 'material_state.dart';

class plasticMaterialCubit extends Cubit<plasticMaterialState> {
  String type = "1";
  String materialtype = "material";
  bool loading = false;
  List<Datum> data = [];
  List<datummoves> datamoves = [];
  bool firstloading = false;
  bool firstloadingmotion = false;
  int motionpage = 1;
  String materialname = "اختر الخامه";
  String colorname = "اختر اللون";
  List<String> materialsnames = [];
  List<String> colorsnames = [];
  Map<String, int> colorid = {};
  bool motionloading = false;

  Map<String, int> materialid = {};
  plasticMaterialCubit(this.materialrepoimp) : super(MaterialInitial());
  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  changematerialtype({required String value}) {
    materialtype = value;
    emit(changetypematerialstate());
  }

  resetdata() {
    materialname = "اختر الخامه";
    colorname = "اختر اللون";
    emit(changetypematerialstate());
  }

  changematerialname(String value) {
    materialname = value;
    emit(changetypematerialstate());
  }

  changecolorname(String value) {
    colorname = value;
    emit(changetypematerialstate());
  }

  final Materialrepoimp materialrepoimp;

  Map<String, dynamic>? queryparms;
  addmaterial({required Materialmodelrequest material}) async {
    emit(AddMaterialLoading());
    var result = await materialrepoimp.addmaterial(material: material);
    result.fold((failure) {
      emit(AddMaterialFailure(errormessage: failure.error_message));
    }, (success) {
      emit(AddMaterialSuccess(successmessage: success));
    });
  }

  addmaterialmove({required Materialmovemodelrequest material}) async {
    emit(AddMaterialmoveLoading());
    var result = await materialrepoimp.addmaterialmove(material: material);
    result.fold((failure) {
      emit(AddMaterialmovefailure(errormessage: failure.error_message));
    }, (success) {
      emit(AddMaterialmovesuccess(successmessage: success));
    });
  }

  updatematerial(
      {required double quantity, required int id, required String type}) async {
    emit(Updatematerialloading());
    var result = await materialrepoimp.editmaterial(
        id: id, type: type, quantity: quantity);
    result.fold((failure) {
      emit(updatematerialfailure(errormessage: failure.error_message));
    }, (success) {
      emit(updatematerialsuccess(successmessage: success));
    });
  }

  getMaterials({required int page}) async {
    if (firstloading == false) emit(GetMaterialsLoading());
    var result =
        await materialrepoimp.getmateriales(page: page, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(GetMaterialsFailure(errormessage: failue.error_message));
    }, (success) {
      data.clear();
      materialsnames.clear();
      colorsnames.clear();
      firstloading = true;
      success.data!.forEach((e) {
        data.add(e);

        if (e.type == "masterpatch") {
          colorsnames.add(e.name!);
          colorid.addAll({e.name!: e.id!});
        } else {
          if (!materialsnames.contains(e.name)) {
            materialsnames.add(e.name!);
            materialid.addAll({e.name!: e.id!});
          }
        }
      });
      emit(GetMaterialsSuccess(successmessage: ""));
    });
  }

  deleteMaterial({required int Materialid, String? type}) async {
    emit(DeleteMaterialsLoading());
    var result = await materialrepoimp.deleteMaterial(
        Materialid: Materialid, type: type);
    result.fold((failure) {
      emit(DeleteMaterialsFailure(errormessage: failure.error_message));
    }, (success) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].id == Materialid && data[i].materialType == type)
          data.removeAt(i);
      }

      emit(DeleteMaterialSuccess(successmessage: success));
    });
  }

  deleteMaterialmoves({required int Materialid}) async {
    emit(deletematerialmovesloading());
    var result =
        await materialrepoimp.deleteMaterialmove(Materialid: Materialid);
    result.fold((failure) {
      emit(deletematerialmovesfailure(errormessage: failure.error_message));
    }, (success) {
      for (int i = 0; i < datamoves.length; i++) {
        if (datamoves[i].id == Materialid) datamoves.removeAt(i);
      }

      emit(deletematerialmovessuccess(successmessage: success));
    });
  }

  gematerialesmoves(
      {required int materialid,
      String? datefrom,
      String? dateto,
      String? type}) async {
    if (firstloadingmotion == false) emit(GetMaterialsmovesLoading());
    this.motionpage = 1;
    var result = await materialrepoimp.getmaterialesmoves(
        datefrom: datefrom,
        dateto: dateto,
        type: type,
        page: motionpage,
        materialid: materialid);
    motionloading = true;
    result.fold((failue) {
      emit(GetMaterialsmovesfailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        motionloading = false;
      }
      datamoves.clear();

      firstloadingmotion = true;
      success.data!.forEach((e) {
        datamoves.add(e);
      });

      emit(GetMaterialsmovessuccess(successmessage: ""));
    });
  }
}
