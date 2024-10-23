import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'component_state.dart';

class plasticcomponentCubit extends Cubit<plasticcomponentState> {
  String type = "اضافه";

  plasticcomponentCubit() : super(componentInitial());
  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }
}
