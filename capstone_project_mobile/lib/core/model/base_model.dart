class BaseModel {
  final String id;
  final String createdAt;
  final String updatedAt;

  BaseModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BaseModel.fromjson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt,
      } =>
        BaseModel(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        ),
      _ => throw const FormatException('Failed to load base model.'),
    };
  }
}
