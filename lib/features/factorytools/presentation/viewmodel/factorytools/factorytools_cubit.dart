import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'factorytools_state.dart';

class FactorytoolsCubit extends Cubit<FactorytoolsState> {
  FactorytoolsCubit() : super(FactorytoolsInitial());

  String type = "PUT";

  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }
}
