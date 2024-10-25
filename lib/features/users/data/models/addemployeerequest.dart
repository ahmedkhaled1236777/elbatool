import 'package:dio/dio.dart';

class addemployeemodel {
  dynamic? image;
  final String password;
  final String name;
  final String isactive;
  final String phone;
  final String email;
  final String password_confirmation;
  final String jobtittle;
  final List<String> permessions;

  addemployeemodel(
      {required this.password,
      required this.email,
      required this.name,
      required this.password_confirmation,
      required this.jobtittle,
      required this.phone,
      required this.isactive,
      required this.permessions,
      this.image});
  FormData tojson() => FormData.fromMap({
        if (image != null) "image": image,
        "email": email,
        "name": name,
        "phone": phone,
        "password_confirmation": password_confirmation,
        "job_title": jobtittle,
        "password": password,
        "permissions[]": permessions,
      });
}
