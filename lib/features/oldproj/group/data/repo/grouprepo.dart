import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/oldproj/group/data/model/geoupmodel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Grouprepo {
  Future<Either<failure, String>> addgroup(
      {required groupmodel group, required BuildContext context});

  Future<Either<failure, List<groupmodel>>> getgroups(
      {required BuildContext context});
}
