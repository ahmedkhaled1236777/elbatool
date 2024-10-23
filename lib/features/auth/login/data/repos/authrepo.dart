import 'dart:io';

import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/auth/login/data/model/loginmodel/loginmodel.dart';
import 'package:agman/features/auth/login/data/model/loginrequest.dart';
import 'package:agman/features/auth/login/data/model/updatemodel/updatemodel.dart';
import 'package:dartz/dartz.dart';

abstract class Authrepo {
  Future<Either<failure, Loginmodel>> login({required loginrequest login});
  Future<Either<failure, String>> logout();
  Future<Either<failure, Updatemodel>> updateprofile(
      {required String email,
      required String phone,
      required String name,
      required String oldpass,
      required String newpass,
      File? photo});
}
