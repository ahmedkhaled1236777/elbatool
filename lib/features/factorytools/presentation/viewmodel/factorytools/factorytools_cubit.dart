import 'dart:ffi';

import 'package:agman/features/factorytools/data/models/factorytoolmodelrequest.dart';
import 'package:agman/features/factorytools/data/models/factorytoolmotionrequest.dart';
import 'package:agman/features/factorytools/data/models/factorytoolssearch/datum.dart';
import 'package:agman/features/factorytools/data/repos/factorytoolsrepoimp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/factorytools/datum.dart';
import '../../../data/models/factorytoolsmoves/datum.dart';

part 'factorytools_state.dart';

class FactorytoolsCubit extends Cubit<FactorytoolsState> {
  FactorytoolsCubit(this.factorytoolsrepoimp) : super(FactorytoolsInitial());
  final Factorytoolsrepoimp factorytoolsrepoimp;
  String type = "1";
  String toolname = "اختر الاداه";
  bool firstloading = false;
  List<Datum> data = [];
  List<Datumsearch> factools = [];
  List<String> tools = [];
  List<datummoves> datamoves = [];
  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  changettoolname({required String value}) {
    toolname = value;
    emit(changetypestate());
  }

  addtool({required Factorytoolmodelrequest factorytool}) async {
    emit(addtoolloading());
    var result =
        await factorytoolsrepoimp.addfactorytool(factorytool: factorytool);
    result.fold((failure) {
      emit(addtoolfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addtoolsuccess(successmessage: success));
    });
  }

  addtoolmotion({required Factorytoolmotionrequest factorytool}) async {
    emit(addtoolmotionloading());
    var result = await factorytoolsrepoimp.addfactorytoolmotion(
        factorytool: factorytool);
    result.fold((failure) {
      emit(addtoolmotionfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addtoolmotionsuccess(successmessage: success));
    });
  }

  updatetool(
      {required Factorytoolmodelrequest factorytool,
      required int factorytoolid}) async {
    emit(edittoolloading());
    var result = await factorytoolsrepoimp.editfactorytool(
        factorytool: factorytool, factorytoolid: factorytoolid);
    result.fold((failure) {
      emit(edittoolfailure(errormessage: failure.error_message));
    }, (success) {
      emit(edittoolsuccess(successmessage: success));
    });
  }

  deletetool({
    required int factorytoolid,
  }) async {
    emit(deletetoolloading());
    var result = await factorytoolsrepoimp.deletefactorytool(
        factorytoolid: factorytoolid);
    result.fold((failure) {
      emit(deletetoolfailure(errormessage: failure.error_message));
    }, (success) {
      data.removeWhere((e) {
        return e.id == factorytoolid;
      });
      emit(deletetoolsuccess(successmessage: success));
    });
  }

  deletetoolmove({
    required int factorytoolid,
  }) async {
    emit(deletetoolmoveloading());
    var result =
        await factorytoolsrepoimp.deletefactorytoolmove(move_id: factorytoolid);
    result.fold((failure) {
      emit(deletetoolmovefailure(errormessage: failure.error_message));
    }, (success) {
      datamoves.removeWhere((e) {
        return e.id == factorytoolid;
      });
      emit(deletetoolmovesuccess(successmessage: success));
    });
  }

  getfactorytools({Map<String, dynamic>? queryparms}) async {
    emit(gettoolloading());
    var result =
        await factorytoolsrepoimp.getfactorytools(queryparms: queryparms);
    result.fold((failue) {
      emit(gettoolfailure(errormessage: failue.error_message));
    }, (success) {
      data.clear();
      tools.clear();
      success.data!.forEach((e) {
        data.add(e);
        tools.add(e.name!);
      });
      firstloading = true;

      emit(gettoolsuccess(successmessage: ""));
    });
  }

  getfactorytoolswithsearch(
      {required String datefrom, required String dateto}) async {
    emit(gettoolloading());
    var result = await factorytoolsrepoimp.getfactorytoolssearch(
        queryparms: {"date_from": datefrom, "date_to": dateto});
    result.fold((failue) {
      emit(gettoolfailure(errormessage: failue.error_message));
    }, (success) {
      factools.clear();
      success.data!.forEach((e) {
        factools.add(e);
      });

      emit(gettoolsuccess(successmessage: ""));
    });
  }

  getfactorytoolsmotion({required int id}) async {
    emit(gettoolmotionloading());
    var result =
        await factorytoolsrepoimp.getfactorytoolsmotion(factorytoolid: id);
    result.fold((failue) {
      emit(gettoolmotionfailure(errormessage: failue.error_message));
    }, (success) {
      datamoves = success.data!;

      emit(gettoolmotionsuccess(successmessage: ""));
    });
  }
}
