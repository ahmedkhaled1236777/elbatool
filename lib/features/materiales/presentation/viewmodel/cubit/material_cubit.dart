import 'package:agman/features/materiales/data/models/materialmodelrequest.dart';
import 'package:agman/features/materiales/data/repos/materialrepoimp.dart';
import 'package:bloc/bloc.dart';

import '../../../data/models/materialmodel/datum.dart';

part 'material_state.dart';

class plasticMaterialCubit extends Cubit<plasticMaterialState> {
  String type = "1";
  String materialtype = "MATERIAL";
  String materialname = "اختر الخامه";
  String colorname = "اختر اللون";
  List<String> materialsnames = [];
  List<String> colorsnames = [];
  Map<String, int> colorid = {};
  Map<String, int> materialid = {};
  plasticMaterialCubit(this.materialrepoimp) : super(MaterialInitial());
  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  changematerialtype({required String value}) {
    materialname = value;
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
  int page = 1;
  bool loading = false;
  List<Datum> data = [];
  bool firstloading = false;
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
}
