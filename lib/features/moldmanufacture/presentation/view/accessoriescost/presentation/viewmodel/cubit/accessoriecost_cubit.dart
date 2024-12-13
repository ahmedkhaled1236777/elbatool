import 'package:agman/features/moldmanufacture/presentation/view/accessoriescost/data/model/accessoriescostmodelrequest.dart';
import 'package:agman/features/moldmanufacture/presentation/view/accessoriescost/data/repos/accessoriecostrepoimp.dart';
import 'package:bloc/bloc.dart';

import '../../../data/model/accessoriecostmodel/datum.dart';

part 'accessoriecost_state.dart';

class accessoriecostCubit extends Cubit<accessoriecostState> {
  final Accessoriecostrepoimp accessoriecostrepo;
  accessoriecostCubit({required this.accessoriecostrepo})
      : super(accessoriecostInitial());

  List<Datum> data = [];
  bool firstloading = false;
  addaccessoriecost(
      {required accessoriecostmodelrequest accessoriecost}) async {
    emit(addaccessoriecostloading());
    var result = await accessoriecostrepo.addaccessoriecost(
        accessoriemodel: accessoriecost);
    result.fold((failure) {
      emit(addaccessoriecostfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addaccessoriecostsuccess(successmessage: success));
    });
  }

  getaccessoriescosts({required int stampid}) async {
    if (firstloading == false) emit(getaccessoriecostloading());
    var result = await accessoriecostrepo.getaccessoriecost(stampid: stampid);
    result.fold((failue) {
      emit(getaccessoriecostfailure(errormessage: failue.error_message));
    }, (success) {
      data.clear();
      firstloading = true;
      data.addAll(success.data!);
      emit(getaccessoriecostsuccess(successmessage: ""));
    });
  }

  deleteaccessoriecost({
    required int id,
  }) async {
    emit(deleteaccessoriecostloading());
    var result = await accessoriecostrepo.deleteaccessoriecost(id: id);
    result.fold((failure) {
      emit(deleteaccessoriecostfailure(failuremessage: failure.error_message));
    }, (success) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].id == id) {
          data.removeAt(i);
          break;
        }
      }

      emit(deleteaccessoriecostsuccess(successmessage: success));
    });
  }
}
