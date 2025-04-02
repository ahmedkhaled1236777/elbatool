import 'package:agman/features/fingerprint/fingerprint/fingerprintreop.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fingerprint_state.dart';

class FingerprintCubit extends Cubit<FingerprintState> {
  final fingerprintrepo fingerprin;
  FingerprintCubit(this.fingerprin) : super(FingerprintInitial());
  getdata() async {
    emit(Fingerprintloading());
    var result = await fingerprin.getconnect();
    result.fold((left) {
      emit(Fingerprintfailure(errormessage: left.error_message));
    }, (success) {
      emit(Fingerprintsuccess(employes: success));
    });
  }
}
