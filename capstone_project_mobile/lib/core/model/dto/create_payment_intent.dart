class CreatePaymentIntent {
  final String currency;
  final int amount;
  final int credits;
  final String patientId;

  CreatePaymentIntent({
    required this.currency,
    required this.amount,
    required this.credits,
    required this.patientId,
  });

  String get getCurrency => currency;
  int get getAmount => amount;
  int get getCredits => credits;
  String get getPatientId => patientId;
}
