import 'dart:io';

class CreatePost {
  final String body;
  final String patient;
  final List<File>? postPhotos;

  CreatePost({
    required this.body,
    required this.patient,
    required this.postPhotos,
  });

  String get getBody => body;
  String get getPatient => patient;
  List<File>? get getPostPhotos => postPhotos;
}
