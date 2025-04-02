part of 'fingerprint_cubit.dart';

abstract class FingerprintState {}

final class FingerprintInitial extends FingerprintState {}

final class Fingerprintloading extends FingerprintState {}

final class Fingerprintsuccess extends FingerprintState {
  final List<String> employes;

  Fingerprintsuccess({required this.employes});
}

final class Fingerprintfailure extends FingerprintState {
  final String errormessage;

  Fingerprintfailure({required this.errormessage});
}
