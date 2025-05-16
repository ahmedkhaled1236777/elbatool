import 'package:bloc/bloc.dart';
import 'package:agman/features/workers/data/models/workermodel/datum.dart';
import 'package:agman/features/workers/data/models/workermodelrequest.dart';
import 'package:agman/features/workers/data/repos/workerrepoimp.dart';

import '../../../../attendance/data/models/attendancemovemodel/datum.dart'
    show datamoves;

part 'workers_state.dart';

class WorkersCubit extends Cubit<WorkersState> {
  WorkersCubit({required this.workerrepoimp}) : super(WorkersInitial());
  final Workerrepoimp workerrepoimp;
  List<Datum> workers = [];
  List<String> workersnames = [];
  Map workerid = {};

  String workername = "اسم العامل";
  List<datamoves> workersmoves = [];
  changeworker(String value) {
    workername = value;
    emit(changeworkerstate());
  }

  addworker({required Workermodelrequest worker}) async {
    emit(addworkerloading());
    var result = await workerrepoimp.addworker(worker: worker);
    result.fold((failure) {
      emit(addworkerfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addworkersuccess(successmessage: success));
    });
  }

  editworker({required Workermodelrequest worker, required int id}) async {
    emit(editworkerloading());
    var result = await workerrepoimp.editworker(worker: worker, id: id);
    result.fold((failure) {
      emit(editworkerfailure(errormessage: failure.error_message));
    }, (Success) {
      emit(editworkersuccess(successmessage: Success));
    });
  }

  deleteworker({required int workerid}) async {
    emit(deleteworkerloading());
    var result = await workerrepoimp.deletworker(workerid: workerid);
    result.fold((failure) {
      emit(deleteworkerfailure(errormessage: failure.error_message));
    }, (Success) {
      workers.removeWhere((e) {
        return e.id == workerid;
      });
      emit(deleteworkersuccess(successmessage: Success));
    });
  }

  getworkers({Map<String, dynamic>? queryparma}) async {
    emit(getworkerloading());
    var result = await workerrepoimp.getworkers(queryparma: queryparma);
    result.fold((failure) {
      emit(getworkerfailure(errormessage: failure.error_message));
    }, (Success) {
      workersnames.clear();
      workers.clear();
      Success.data!.forEach((e) {
        workerid.addAll({e.name!: e.id});
        workers.add(e);
        workersnames.add(e.name!);
      });
      emit(getworkersuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  getworkersmoves(
      {required String workerid,
      required String month,
      required String year}) async {
    emit(getworkermovesloading());
    var result = await workerrepoimp.getworkersmoves(
        workerid: workerid, month: month, year: year);
    result.fold((failure) {
      emit(getworkermovesfailure(errormessage: failure.error_message));
    }, (Success) {
      workersmoves = Success.data!;
      emit(getworkermovessuccess(
          successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }
}
