import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

class CategoryModel extends Category {
  CategoryModel({
    required String name,
    required String imageUrl,
    String? userId,
  }) : super(
          name: name,
          imageUrl: imageUrl,
          userId: userId,
        );

  /// Converts Firestore data to a `CategoryModel`
  factory CategoryModel.fromMap(String id, Map<String, dynamic> data) {
    return CategoryModel(
      name: data['name'] as String,
      imageUrl: data['imageUrl'] as String,
      userId: data['userId'] as String?,
    );
  }

  /// Converts `CategoryModel` to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }
}
