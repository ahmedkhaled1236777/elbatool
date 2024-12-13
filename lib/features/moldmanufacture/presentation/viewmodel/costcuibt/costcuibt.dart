import 'package:agman/features/moldmanufacture/data/model/moldmanufacturerequest.dart';
import 'package:agman/features/moldmanufacture/data/repo/moldmanufacturerepoimp.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/coststates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/moldmanufacturemodel/datum.dart';

class Costcuibt extends Cubit<Coststates> {
  final Moldmanufacturerepoimp moldmanufacturerepoimp;
  Costcuibt(this.moldmanufacturerepoimp) : super(costintial());
  String? is_active;
  int page = 1;
  Map<int, String> intialcost = {};
  Map<int, String> accessories = {};
  Map<int, String> manufacture = {};
  bool loading = false;
  List<Datum> data = [];
  bool firstloading = false;
  Map<String, dynamic>? queryparms;

  addmoldmanufacture({required Moldmanufacturerequest moldmanufacture}) async {
    emit(addmoldmanufactureloading());
    var result =
        await moldmanufacturerepoimp.addmold(moldrequest: moldmanufacture);
    result.fold((failure) {
      emit(addmoldmanufacturefailure(errorrmessage: failure.error_message));
    }, (success) {
      emit(addmoldmanufacturesuccess(successmessage: success));
    });
  }

  getmoldmanufacture() async {
    if (firstloading == false) emit(getmoldsmanufactureloading());
    this.page = 1;
    var result = await moldmanufacturerepoimp.getmoldsmanufacture(
        page: page, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(getmoldsmanufacturefailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        loading = false;
      }
      data.clear();

      firstloading = true;
      success.data!.forEach((e) {
        intialcost.addAll(
            {e.id!: e.initialCost == null ? "0" : e.initialCost.toString()});
        accessories.addAll({
          e.id!:
              e.accessoryInitial == null ? "0" : e.accessoryInitial.toString()
        });
        manufacture.addAll({
          e.id!: e.industrialCost == null ? "0" : e.industrialCost.toString()
        });
        data.add(e);
      });

      emit(getmoldmanufacturesuccess(successmessage: ""));
    });
  }

  getmoremoldsmanufacture() async {
    page++;
    var result = await moldmanufacturerepoimp.getmoldsmanufacture(
        page: page, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(getmoldsmanufacturefailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        loading = false;
      }

      success.data!.forEach((e) {
        intialcost.addAll(
            {e.id!: e.initialCost == null ? "0" : e.initialCost.toString()});
        accessories.addAll({
          e.id!:
              e.accessoryInitial == null ? "0" : e.accessoryInitial.toString()
        });
        manufacture.addAll({
          e.id!: e.industrialCost == null ? "0" : e.industrialCost.toString()
        });
        data.add(e);
        data.add(e);
      });
      emit(getmoldmanufacturesuccess(successmessage: ""));
    });
  }

  deletemoldmanufacture({required int stampid}) async {
    emit(deletemoldmanufactureloading());
    var result = await moldmanufacturerepoimp.deletestampmanufacture(
      stampid: stampid,
    );
    result.fold((failure) {
      emit(deletemoldmanufacturefailure(errrormessage: failure.error_message));
    }, (success) {
      data.removeWhere((item) => item.id == stampid);

      emit(deletemoldmanufacturesuccess(successmessage: success));
    });
  }

  editmoldmanufacture(
      {required Moldmanufacturerequest stamp, required int stampid}) async {
    emit(editmoldmanufactureloading());
    var result = await moldmanufacturerepoimp.editmoldmanufacture(
        stamp: stamp, stampid: stampid);
    result.fold((failure) {
      emit(editmoldmanufacturefailure(errormessage: failure.error_message));
    }, (success) {
      emit(editmoldmanufacturesuccess(succcessmessage: success));
    });
  }
}
