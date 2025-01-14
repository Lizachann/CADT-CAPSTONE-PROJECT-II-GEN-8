import 'package:capstone_project_mobile/core/model/base_model.dart';

class PostPhoto extends BaseModel {
  final String filename;
  // final Post post;

  PostPhoto({
    required this.filename,
    // required this.post,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PostPhoto.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt,
        'filename': String filename,
      } =>
        PostPhoto(
          filename: filename,
          // post: json['post'],
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        ),
      _ => throw const FormatException('Fialed to load post photo')
    };
  }
}
