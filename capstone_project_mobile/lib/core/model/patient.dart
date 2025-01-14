import 'package:capstone_project_mobile/core/model/base_model.dart';
import 'package:capstone_project_mobile/core/model/credential.dart';

class Patient extends BaseModel {
  final Credential credential;
  final String username;
  final String gender;
  final String? refreshToken;
  final int credits;
  final int stressMonitorCount;
  final int mindCheckupCount;
  final bool isBanned;
  final List<dynamic> roles;
  final String profileImg;

  Patient({
    required this.credential,
    required this.username,
    required this.gender,
    this.refreshToken,
    required this.credits,
    required this.mindCheckupCount,
    required this.stressMonitorCount,
    required this.isBanned,
    required this.roles,
    required this.profileImg,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'username': String username,
        'gender': String gender,
        'credits': int credits,
        'is_banned': bool isBanned,
        'roles': List<dynamic> roles,
        '_id': String id,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt,
        'stress_monitor_count': int stressMonitorCount,
        'mind_checkup_count': int mindCheckupCount,
        'profile_img': String profileImg,
      } =>
        Patient(
          credential: Credential.fromJson(json['credential']),
          username: username,
          gender: gender,
          credits: credits,
          mindCheckupCount: mindCheckupCount,
          stressMonitorCount: stressMonitorCount,
          isBanned: isBanned,
          roles: roles,
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          profileImg: profileImg,
        ),
      _ => throw const FormatException('Failed to load patient.'),
    };
  }
}
