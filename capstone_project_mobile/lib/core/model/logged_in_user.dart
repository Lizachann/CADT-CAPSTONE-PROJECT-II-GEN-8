class LoggedInUser {
  String id;
  String username;
  String email;
  String password;
  int credits;

  LoggedInUser(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.credits});
}
