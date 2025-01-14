class SaveTotalScore {
  final int totalScore;
  final String patient;

  SaveTotalScore({
    required this.totalScore,
    required this.patient,
  });

  int get getTotalScore => totalScore;
  String get getPatient => patient;
}
