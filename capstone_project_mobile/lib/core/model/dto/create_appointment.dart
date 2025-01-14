class CreateAppointment {
  final String? note;
  final String symptoms;
  final String patient;
  final String therapist;
  final String scheduleDate;
  final String startTime;
  final String? endTime;
  final int duration;

  CreateAppointment({
    this.note,
    required this.symptoms,
    required this.therapist,
    required this.patient,
    required this.scheduleDate,
    required this.startTime,
    this.endTime,
    required this.duration,
  });

  String? get getNote => note;
  String get getSymtoms => symptoms;
  String get getPatient => patient;
  String get getTherapist => therapist;
  String get getScheduleDate => scheduleDate;
  String get getStartTime => startTime;
  String? get getEndTime => endTime;
  int? get getDuration => duration;
}
