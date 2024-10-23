import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'accessories_state.dart';

class plasticaccessoriesCubit extends Cubit<plasticaccessoriesState> {
  String type = "اضافه";

  plasticaccessoriesCubit() : super(accessoriesInitial());
  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }
}
