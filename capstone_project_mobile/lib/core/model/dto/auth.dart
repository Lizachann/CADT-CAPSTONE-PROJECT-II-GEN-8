class Auth {
  final String email;
  final String password;

  Auth({
    required this.email,
    required this.password,
  });

  String get getEmail => email;
  String get getPassword => password;
}