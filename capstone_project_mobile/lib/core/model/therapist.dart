import 'package:capstone_project_mobile/core/model/base_model.dart';

class Therapist extends BaseModel {
  final String firstName;
  final String lastName;
  final String username;
  final String bio;
  final String email;
  final String phoneNumber;
  final int hourlyRate;
  final String gender;
  final List<dynamic> specializations;
  final List<dynamic> roles;
  final bool isDeleted;

  Therapist({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.hourlyRate,
    required this.gender,
    required this.bio,
    required this.isDeleted,
    required this.roles,
    required this.specializations,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory Therapist.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'first_name': String firstName,
        'last_name': String lastName,
        'email': String email,
        'username': String username,
        'phone_number': String phoneNumber,
        'hourly_rate': int hourlyRate,
        'gender': String gender,
        'bio': String bio,
        'is_deleted': bool isDeleted,
        'roles': List<dynamic> roles,
        'specializations': List<dynamic> specializations,
        '_id': String id,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt,
      } =>
        Therapist(
          bio: bio,
          firstName: firstName,
          lastName: lastName,
          email: email,
          gender: gender,
          isDeleted: isDeleted,
          phoneNumber: phoneNumber,
          hourlyRate: hourlyRate,
          specializations: specializations,
          username: username,
          roles: roles,
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        ),
      _ => throw const FormatException('Failed to load therapist.'),
    };
  }
}
