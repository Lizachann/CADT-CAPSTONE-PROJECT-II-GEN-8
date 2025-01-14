import 'package:capstone_project_mobile/core/model/base_model.dart';

class CreateMindCheckup extends BaseModel {
  final String result;
  final String patient;

  CreateMindCheckup({
    required this.result,
    required this.patient,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CreateMindCheckup.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt,
        'result': String result,
        'patient': String patient,
      } =>
        CreateMindCheckup(
            result: result,
            patient: patient,
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt),
      _ => throw const FormatException('Failed to load mind checkup')
    };
  }
}
