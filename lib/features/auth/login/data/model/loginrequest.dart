class loginrequest {
  final String password;
  final String email;
  final String token;

  loginrequest(
      {required this.password, required this.email, required this.token});
  tojson() => {"password": password, "email": email, "token": this.token};
}
