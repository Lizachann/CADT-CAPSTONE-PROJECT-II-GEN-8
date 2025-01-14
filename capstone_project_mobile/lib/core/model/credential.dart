import 'package:capstone_project_mobile/core/model/base_model.dart';

class Credential extends BaseModel {
  final String email;
  final String password;

  Credential({
    required this.email,
    required this.password,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory Credential.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'email': String email,
        'password': String password,
        '_id': String id,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt,
      } =>
        Credential(
          email: email,
          password: password,
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        ),
      _ => throw const FormatException('Failed to load Credential.'),
    };
  }
}
