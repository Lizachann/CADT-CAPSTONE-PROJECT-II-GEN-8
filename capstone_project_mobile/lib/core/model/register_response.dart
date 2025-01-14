import 'package:capstone_project_mobile/core/model/base_model.dart';

class RegisterResponse extends BaseModel {
  final String credential;
  final String username;
  final List<dynamic> roles;
  final String email;

  RegisterResponse({
    required this.credential,
    required this.username,
    required this.roles,
    required this.email,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt,
        'username': String username,
        'email': String email,
        'roles': List<dynamic> roles,
        'credential': String credential,
      } =>
        RegisterResponse(
          credential: credential,
          username: username,
          roles: roles,
          email: email,
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        ),
      _ => throw const FormatException('Failed to load Register response')
    };
  }
}
