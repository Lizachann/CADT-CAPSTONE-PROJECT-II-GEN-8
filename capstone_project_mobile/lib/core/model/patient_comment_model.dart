import 'package:capstone_project_mobile/core/model/base_model.dart';
import 'package:capstone_project_mobile/core/model/patient.dart';

class ParentCommentV2 extends BaseModel {
  final String content;
  final Patient patient;
  final String post;
  ParentCommentV2({
    required this.content,
    required this.patient,
    required this.post,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ParentCommentV2.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt,
        'content': String content,
        'post': String post,
      } =>
        ParentCommentV2(
          content: content,
          patient: Patient.fromJson(json['patient']),
          post: post,
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        ),
      _ => throw const FormatException('Failed to load Parent comment v2')
    };
  }
}
