import 'package:agman/features/materiales/data/models/materialmodelrequest.dart';
import 'package:agman/features/materiales/data/repos/materialrepoimp.dart';
import 'package:bloc/bloc.dart';

import '../../../data/models/materialmodel/content.dart';

part 'material_state.dart';

class plasticMaterialCubit extends Cubit<plasticMaterialState> {
  String type = "PUT";
  String materialtype = "MATERIAL";

  plasticMaterialCubit(this.materialrepoimp) : super(MaterialInitial());
  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  changematerialtype({required String value}) {
    materialtype = value;
    emit(changetypematerialstate());
  }

  final Materialrepoimp materialrepoimp;
  int page = 1;
  bool loading = false;
  List<Content> data = [];
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
      {required Materialmodelrequest material, required int id}) async {
    emit(Updatematerialloading());
    var result = await materialrepoimp.editmaterial(material: material, id: id);
    result.fold((failure) {
      emit(updatematerialfailure(errormessage: failure.error_message));
    }, (success) {
      emit(updatematerialsuccess(successmessage: success));
    });
  }

  getMaterials({required int page}) async {
    if (firstloading == false) emit(GetMaterialsLoading());
    this.page = 1;
    var result =
        await materialrepoimp.getmateriales(page: page, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(GetMaterialsFailure(errormessage: failue.error_message));
    }, (success) {
      print(data);
      if (success.data!.pagination!.links!.next == null) {
        loading = false;
      }
      data.clear();
      firstloading = true;
      data.addAll(success.data!.content!);
      emit(GetMaterialsSuccess(successmessage: ""));
    });
  }

  getamoreMaterials() async {
    page++;
    var result =
        await materialrepoimp.getmateriales(page: page, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(GetMaterialsFailure(errormessage: failue.error_message));
    }, (success) {
      if (success.data!.pagination!.links!.next == null) {
        loading = false;
      }
      data.addAll(success.data!.content!);
      emit(GetMaterialsSuccess(successmessage: ""));
    });
  }

  deleteMaterial({required int Materialid}) async {
    emit(DeleteMaterialsLoading());
    var result = await materialrepoimp.deleteMaterial(
      Materialid: Materialid,
    );
    result.fold((failure) {
      emit(DeleteMaterialsFailure(errormessage: failure.error_message));
    }, (success) {
      data.removeWhere((e) {
        return e.id == Materialid;
      });
      emit(DeleteMaterialSuccess(successmessage: success));
    });
  }
}
