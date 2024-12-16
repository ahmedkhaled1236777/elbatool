import 'package:bloc/bloc.dart';

part 'save_state.dart';

class SaveCubit extends Cubit<SaveState> {
  SaveCubit() : super(SaveInitial());
  String savetype = "DELETE";

  changesavetype(String val) {
    savetype = val;
    emit(changesavestate());
  }
}
