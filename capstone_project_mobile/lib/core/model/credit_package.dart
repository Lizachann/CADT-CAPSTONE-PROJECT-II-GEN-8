import 'package:capstone_project_mobile/core/model/base_model.dart';

class CreditPackage extends BaseModel {
  final String title;
  final int points;
  final int price;
  final int discount;
  final bool isVisible;

  CreditPackage({
    required super.id,
    required this.title,
    required this.points,
    required this.price,
    required this.discount,
    required this.isVisible,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CreditPackage.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'title': String title,
        'points': int points,
        'price': int price,
        'discount': int discount,
        'is_visible': bool isVisible,
        'createdAt': String createdAt,
        'updatedAt': String updatedAt,
      } =>
        CreditPackage(
          id: id,
          title: title,
          points: points,
          price: price,
          discount: discount,
          isVisible: isVisible,
          createdAt: createdAt,
          updatedAt: updatedAt,
        ),
      _ => throw const FormatException('Failed to load credits package.'),
    };
  }
}
