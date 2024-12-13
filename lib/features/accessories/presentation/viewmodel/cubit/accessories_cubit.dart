import 'dart:collection';

import 'package:agman/features/accessories/data/model/accessoriemodel/datum.dart';
import 'package:agman/features/accessories/data/model/accessoriemodelrequest.dart';
import 'package:agman/features/accessories/data/model/deleteputmodelrequest.dart';
import 'package:agman/features/accessories/data/repos/accessorierepoimp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/accessoriemotionmodel/datum.dart';

part 'accessories_state.dart';

class plasticaccessoriesCubit extends Cubit<plasticaccessoriesState> {
  int type = 1;
  final Accessorierepoimp accessorierepoimp;
  plasticaccessoriesCubit({required this.accessorierepoimp})
      : super(accessoriesInitial());
  int page = 1;
  Map<String, dynamic>? queryparms;

  bool loading = false;
  List<Datum> data = [];
  bool firstloading = false;
  int motionpage = 1;
  String accessoriename = "اختر الاكسسوار";
  List<String> accessoriesnames = [];
  Map<String, int> accessorieid = {};
  bool motionloading = false;
  List<DatumMOTION> alldata = [];
  bool firstloadingmotion = false;

  changetype({required int value}) {
    type = value;
    emit(changetypestate());
  }

  changeaccessorie(String value) {
    accessoriename = value;
    emit(changetypestate());
  }

  addaccessorie({required Accessoriemodelrequest accessorie}) async {
    emit(addaccessorieloading());
    var result = await accessorierepoimp.addaccessorie(accessorie: accessorie);
    result.fold((failure) {
      emit(addaccessoriefailure(errormessage: failure.error_message));
    }, (success) {
      emit(addaccessoriesuccess(successmessage: success));
    });
  }

  putordeleteaccessorie({required Deleteputmodelrequest accessorie}) async {
    emit(addordeleteloading());
    var result =
        await accessorierepoimp.putordeleteaccessorie(accessorie: accessorie);
    result.fold((failure) {
      emit(addordeletefailure(errormessage: failure.error_message));
    }, (success) {
      emit(addordeletesuccess(successmessage: success));
    });
  }

  getaccessories() async {
    if (firstloading == false) emit(getaccessoriesloading());
    var result = await accessorierepoimp.getaccessories(queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(getaccessoriesfailure(errormessage: failue.error_message));
    }, (success) {
      data.clear();
      accessoriesnames.clear();
      firstloading = true;
      success.data!.forEach((e) {
        data.add(e);
        accessoriesnames.add(e.name!);
        accessorieid.addAll({e.name!: e.id!});
      });

      emit(getaccessoriessuccess(successmessage: ""));
    });
  }

  getaccessoriesmotion({required int accessorieid}) async {
    if (firstloadingmotion == false) emit(getaccessoriesmotionloading());
    this.motionpage = 1;
    var result = await accessorierepoimp.getaccessoriesmotion(
        page: motionpage, accessorieid: accessorieid);
    motionloading = true;
    result.fold((failue) {
      emit(getaccessoriesmotionfailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        motionloading = false;
      }
      alldata.clear();

      firstloadingmotion = true;
      success.data!.forEach((e) {
        alldata.add(e);
      });

      emit(getaccessoriesmotionsuccess(successmessage: ""));
    });
  }

  getmoreaccessoriesmotion({required int accessorieid}) async {
    motionpage++;
    var result = await accessorierepoimp.getaccessoriesmotion(
        page: motionpage, accessorieid: accessorieid);
    motionloading = true;
    result.fold((failue) {
      emit(getaccessoriesmotionfailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        motionloading = false;
      }
      success.data!.forEach((e) {
        alldata.add(e);
      });
      emit(getaccessoriesmotionsuccess(successmessage: ""));
    });
  }

  deleteaccessorie({required int accessorieid}) async {
    emit(deleteaccessorieloading());
    var result = await accessorierepoimp.deleteaccessorie(
      accessorie_id: accessorieid,
    );
    result.fold((failure) {
      emit(deleteaccessoriefailure(errormessage: failure.error_message));
    }, (success) {
      data.removeWhere((item) => item.id == accessorieid);

      emit(deleteaccessoriesuccess(successmessage: success));
    });
  }

  deleteaccessoriemove({required int moveid}) async {
    emit(deleteaccessoriemoveloading());
    var result = await accessorierepoimp.deletemove(
      move_id: moveid,
    );
    result.fold((failure) {
      emit(deleteaccessoriemovefailure(errormessage: failure.error_message));
    }, (success) {
      alldata.removeWhere((item) => item.id == moveid);

      emit(deleteaccessorienovesuccess(successmessage: success));
    });
  }

  editaccessorie(
      {required Accessoriemodelrequest accessorie,
      required int accessorieid}) async {
    emit(editaccessorieloading());
    var result = await accessorierepoimp.editaccessorie(
        accessorie: accessorie, accessorieid: accessorieid);
    result.fold((failure) {
      emit(editaccessoriefailure(errormessage: failure.error_message));
    }, (success) {
      emit(editaccessoriesuccess(successmessage: success));
    });
  }
}
