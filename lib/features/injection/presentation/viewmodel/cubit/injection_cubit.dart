import 'package:agman/features/injection/data/models/productionmodel.dart';
import 'package:agman/features/injection/data/repo/injectiomrepoimp.dart';
import 'package:bloc/bloc.dart';

part 'injection_state.dart';

class InjectionCubit extends Cubit<InjectionState> {
  InjectionCubit(this.injectiomrepoimp) : super(InjectionInitial());
  final Injectiomrepoimp injectiomrepoimp;
  List<productionmodel> productions = [];
  addoroduction({required productionmodel production}) async {
    emit(addinjectionloading());
    var result =
        await injectiomrepoimp.addinjection(injectionrequest: production);

    result.fold((failure) {
      emit(addinjectionfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addinjectionsuccess(successmessage: success));
    });
  }

  getinjections({required String date}) async {
    emit(getinjectionsloading());
    var result =
        await injectiomrepoimp.getinjections(queryparms: {"date": date});
    result.fold((failure) {
      emit(getinjectiongfailure(errormessage: failure.error_message));
    }, (success) {
      productions = success;
      emit(
          getinjectionssuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  deletereport({required int reportid}) async {
    emit(deleteinjectionloading());
    var result = await injectiomrepoimp.deleteinjection(
      injectionid: reportid,
    );
    result.fold((failure) {
      emit(deleteinjectionfailure(errormessage: failure.error_message));
    }, (success) {
      productions.removeWhere((e) {
        return e.id == reportid;
      });
      emit(deleteinjectionsuccess(successmesssage: success));
    });
  }
}
