import 'package:serve_mate/features/category/domain/entities/category_entities.dart';

class CategoryModel extends Category {
  final String? description; // Add unique fields to the model if needed.

  CategoryModel({
    required String name,
    String? imageUrl,
    String? userId,
    this.description,
  }) : super(
          name: name,
          imageUrl: imageUrl,
          userId: userId,
        );

  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    if (!data.containsKey('name') || !data.containsKey('imageUrl')) {
      throw Exception('Missing required fields in Firestore data.');
    }
    return CategoryModel(
      name: data['name'] as String,
      imageUrl: data['imageUrl'] as String,
      userId: data['userId'] as String?,
      description: data['description'] as String?,
    );
  }

  /// Converts `CategoryModel` to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'userId': userId,
      'description': description,
    };
  }
}
