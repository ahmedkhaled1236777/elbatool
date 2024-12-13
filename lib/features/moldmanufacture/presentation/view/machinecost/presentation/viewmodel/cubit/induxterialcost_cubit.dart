import 'package:agman/features/moldmanufacture/presentation/view/machinecost/data/model/addmachinereques.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/data/repos/machinerepoimp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/machinesmodel/datum.dart';

part 'induxterialcost_state.dart';

class InduxterialcostCubit extends Cubit<InduxterialcostState> {
  final Machinerepoimp machinerepoimp;
  InduxterialcostCubit(this.machinerepoimp) : super(InduxterialcostInitial());
  bool firstloading = true;
  List<Datum> machines = [];
  List<String> machinesnames = [];
  String machinename = "اختر الماكينه";
  Map<String, int> machineid = {};
  changemachine(String value) {
    machinename = value;
    emit(changemachinestate());
  }

  resetmachine() {
    machinename = "اختر الماكينه";
    emit(changemachinestate());
  }

  getmachines() async {
    if (firstloading) emit(getmachinesloading());
    var result = await machinerepoimp.getmachines();
    result.fold((failure) {
      emit(getmachinesfailure(errormessage: failure.error_message));
    }, (success) {
      machines.clear();
      machinesnames.clear();
      success.data!.forEach((e) {
        machines.add(e);
        machinesnames.add(e.name!);
        machineid.addAll({e.name!: e.id!});
      });
      firstloading = false;
      emit(getmachinessuccess(successmessage: success.message!));
    });
  }

  addmachine({required Addmachinereques machine}) async {
    emit(addmachineloading());
    var result = await machinerepoimp.addmachine(machine: machine);
    result.fold((failure) {
      emit(addmachinefailure(errormessage: failure.error_message));
    }, (Suceess) {
      emit(addmachinesuccess(successmessage: Suceess));
    });
  }

  updatemachine({required Addmachinereques machine, required int id}) async {
    emit(editmachineloading());
    var result = await machinerepoimp.editmachine(machine: machine, id: id);
    result.fold((failure) {
      emit(editmachinefailure(errormessage: failure.error_message));
    }, (success) {
      emit(editmachinesuccess(successmessage: success));
    });
  }

  deletemachine({required int machineid}) async {
    emit(deletemachineloading());
    var result = await machinerepoimp.deletemachine(
      machineid: machineid,
    );
    result.fold((failure) {
      emit(deletemachinefailure(errormessage: failure.error_message));
    }, (success) {
      machines.removeWhere((e) {
        return e.id == machineid;
      });
      emit(deletemachinesuccess(successmessage: success));
    });
  }
}
