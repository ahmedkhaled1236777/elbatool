import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/data/model/industerialcostmodel/datum.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/data/model/industerialcostrequest.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/presentation/viewmodel/cubit/industerialcoststste.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/industerialcostrepoimp.dart';

class IndusterialcostCubit extends Cubit<myIndusterialcostState> {
  final Industerialcostrepoimp industerialcostrepoimp;
  IndusterialcostCubit({required this.industerialcostrepoimp})
      : super(myIndusterialcostInitial());
  bool firstloading = false;
  List<Datum> data = [];
  addIndusterialcost({required Industerialcostrequest Industerialcost}) async {
    emit(addmyIndusterialcostloading());
    var result = await industerialcostrepoimp.addindusterialcost(
        industerialcost: Industerialcost);
    result.fold((failure) {
      emit(addmyIndusterialcostfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addmyIndusterialcostsuccess(successmessage: success));
    });
  }

  getindusterialcost({required int stampid}) async {
    if (firstloading == false) emit(getmyIndusterialcostloading());
    var result =
        await industerialcostrepoimp.getindusterialcost(stampid: stampid);
    result.fold((failue) {
      emit(getmyIndusterialcostfailure(errormessage: failue.error_message));
    }, (success) {
      data.clear();
      firstloading = true;
      data.addAll(success.data!);
      emit(getmyIndusterialcostsuccess(successmessage: ""));
    });
  }

  deleteIndusterialcost({
    required int id,
  }) async {
    emit(deletemyIndusterialcostloading());
    var result = await industerialcostrepoimp.deleteindusterialcost(id: id);
    result.fold((failure) {
      emit(deletemyIndusterialcostfailure(
          failuremessage: failure.error_message));
    }, (success) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].id == id) {
          data.removeAt(i);
          break;
        }
      }

      emit(deletemyIndusterialcostsuccess(successmessage: success));
    });
  }
}
