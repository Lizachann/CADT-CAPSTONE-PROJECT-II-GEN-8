import 'dart:io';

class TherapistSignUp {
  final String firstName;
  final String lastName;
  final String email;
  final String status;
  final List<File>? therapistApplicationPhotos;

  TherapistSignUp({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.therapistApplicationPhotos,
    required this.status,
  });
  String get getfirstName => firstName;
  String get getlastName => lastName;
  String get getemail => email;
  String get getstatus => status;

  List<File>? get gettherapistApplicationPhotos => therapistApplicationPhotos;
}