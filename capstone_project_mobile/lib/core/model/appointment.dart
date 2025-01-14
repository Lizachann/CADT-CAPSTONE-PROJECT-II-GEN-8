import 'package:capstone_project_mobile/core/model/base_model.dart';
import 'package:capstone_project_mobile/core/model/patient.dart';
import 'package:capstone_project_mobile/core/model/therapist.dart';

class Appointment extends BaseModel {
  final String note;
  final String prescriptions;
  final String symptoms;
  final String scheduleDate;
  final String startTime;
  final String endTime;
  final int duration;
  final int sessionPrice;
  final String status;
  final Patient patient;
  final Therapist therapist;

  Appointment({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.note,
    required this.prescriptions,
    required this.symptoms,
    required this.scheduleDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.patient,
    required this.therapist,
    required this.duration,
    required this.sessionPrice,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt,
        'note': String note,
        'prescriptions': String prescriptions,
        'symptoms': String symtoms,
        'scheduleDate': String scheduleDate,
        'start_time': String startTime,
        'end_time': String endTime,
        'duration': int duration,
        'session_price': int sessionPrice,
        'status': String status,
      } =>
        Appointment(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            note: note,
            prescriptions: prescriptions,
            symptoms: symtoms,
            scheduleDate: scheduleDate,
            startTime: startTime,
            endTime: endTime,
            duration: duration,
            sessionPrice: sessionPrice,
            status: status,
            patient: Patient.fromJson(json['patient']),
            therapist: Therapist.fromJson(json['therapist'])),
      _ => throw const FormatException('Failed to load appointment.'),
    };
  }
}
