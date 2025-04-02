import 'package:agman/features/molds/data/models/moldmodel/datum.dart';
import 'package:agman/features/molds/data/models/moldmodelrequest.dart';
import 'package:agman/features/molds/data/repos/moldrepoimp.dart';
import 'package:bloc/bloc.dart';
part 'mold_state.dart';

class MoldCubit extends Cubit<MoldState> {
  List<Datum> molds = [];
  List<Datum> filterdata = [];
  List<String> mymold = [];
  final Moldrepoimp moldrepo;
  bool firstloading = true;
  String moldname = "اختر الاسطمبه";
  Map<String, Map> moldid = {};
  Map<int, String> moldfromid = {};
  changemold(String value) {
    moldname = value;
    emit(changemoldstate());
  }

  resetmold() {
    moldname = "اختر الاسطمبه";
    emit(changemoldstate());
  }

  MoldCubit(this.moldrepo) : super(MoldInitial());
  getmolds() async {
    if (firstloading) emit(GetMoldLoading());
    var result = await moldrepo.getmolds();
    result.fold((failure) {
      emit(GetMoldFailure(errormessage: failure.error_message));
    }, (success) {
      mymold.clear();
      molds.clear();
      success.data!.forEach((e) {
        molds.add(e);
        mymold.add(e.name!);
        moldfromid.addAll({e.id!: e.name!});
        moldid.addAll({
          e.name!: {
            "id": e.id,
            "numberofpieces": e.numerOfPieces,
            "cycletime": e.timeOperation
          }
        });
      });
      filterdata = success.data!;
      firstloading = false;
      emit(GetMoldSuccess(successmessage: success.message!));
    });
  }

  addmold({required Moldmodelrequest mold}) async {
    emit(AddMoldLoading());
    var result = await moldrepo.addmold(mold: mold);
    result.fold((failure) {
      emit(AddMoldFailure(errormessage: failure.error_message));
    }, (Suceess) {
      emit(AddMoldSuccess(successmessage: Suceess));
    });
  }

  updatemold({required Moldmodelrequest mold, required int id}) async {
    emit(Updatemoldloading());
    var result = await moldrepo.editmold(mold: mold, id: id);
    result.fold((failure) {
      emit(updatemoldfailure(errormessage: failure.error_message));
    }, (success) {
      emit(updatemoldsuccess(successmessage: success));
    });
  }

  deletemold({required int moldid}) async {
    emit(DeletemoldsLoading());
    var result = await moldrepo.deleteMold(
      moldid: moldid,
    );
    result.fold((failure) {
      emit(DeletemoldsFailure(errormessage: failure.error_message));
    }, (success) {
      molds.removeWhere((e) {
        return e.id == moldid;
      });
      emit(DeletemoldSuccess(successmessage: success));
    });
  }

  searchformold({required String name}) {
    molds = [];
    filterdata.forEach((e) {
      if (e.name!.contains(name)) molds.add(e);
    });
    emit(searchmold());
  }

  resetdata() {
    molds = filterdata;

    emit(searchmold());
  }
}
