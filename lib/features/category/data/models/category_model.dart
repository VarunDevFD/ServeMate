import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

class CategoryModel extends Category {
  final String? description;
  const CategoryModel({
    required super.name,
    required super.imageUrl,
    super.userId,
    this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      userId: json['userId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'userId': userId,
      'description': description,
    };
  }
}
