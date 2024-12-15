import 'package:agman/features/injection/data/models/productionmodel.dart';
import 'package:agman/features/injection/data/repo/injectiomrepoimp.dart';
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';
import 'package:agman/features/orders/presentation/viewmodel/cubit/orders_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    var result = await injectiomrepoimp.getinjections(date: date);
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

  gertmoldsandorders({required BuildContext context}) async {
    try {
      emit(getmoldandordersloading());
      await BlocProvider.of<OrdersCubit>(context).getorders();
      await BlocProvider.of<MoldCubit>(context).getmolds();
      emit(getmoldandorderssuccess(successmessage: "successmessage"));
    } catch (e) {
      emit(getmoldandordersfailure(errormessage: e.toString()));
    }
  }
}
