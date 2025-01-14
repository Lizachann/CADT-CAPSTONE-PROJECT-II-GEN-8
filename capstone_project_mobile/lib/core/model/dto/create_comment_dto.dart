class CreateCommentDto {
  final String content;
  final String patient;
  final String post;

  CreateCommentDto({
    required this.content,
    required this.patient,
    required this.post,
  });

  String get getContent => content;
  String get getPatient => patient;
  String get getPost => post;
}
