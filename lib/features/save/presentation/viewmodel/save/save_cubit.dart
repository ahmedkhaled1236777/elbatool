import 'package:agman/features/save/data/model/savemodel/all_cash.dart';
import 'package:agman/features/save/data/model/savemodelrequest.dart';
import 'package:agman/features/save/data/repos/saverepoimp.dart';
import 'package:bloc/bloc.dart';

part 'save_state.dart';

class SaveCubit extends Cubit<SaveState> {
  final Saverepoimp saverepoimp;
  SaveCubit(this.saverepoimp) : super(SaveInitial());
  String savetype = "0";
  List<AllCash> data = [];
  String? date;
  double total = 0;
  double totalsearch = 0;
  changesavetype(String val) {
    savetype = val;
    emit(changesavestate());
  }

  addsavemotion({required Savemodelrequest saverequest}) async {
    emit(addsaveloading());
    var result = await saverepoimp.addsavemotion(saverequest: saverequest);
    result.fold((failure) {
      emit(addsavefailure(errormessage: failure.error_message));
    }, (success) {
      emit(addsavesuccess(successmessage: success));
    });
  }

  getsavemotion({required String date}) async {
    emit(getsaveloading());
    var result = await saverepoimp.getsave(date: date);
    result.fold((failure) {
      emit(getsavefailure(errormessage: failure.error_message));
    }, (success) {
      data = success.data!.allCash!;
      total = success.data!.currentCash ?? 0;
      totalsearch = success.data!.sumDay!;
      emit(getsavesuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }
}
