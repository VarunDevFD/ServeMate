import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_page_category_cards.dart';

class HomeCategoryDataWidget extends StatelessWidget {
  const HomeCategoryDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return CategoryCards(
          name: 'Unknown',
          // details: (category['details'] as List<dynamic>?)
          //         ?.map((e) => e.toString())
          //         .toList() ??
          //     [], // Converts category details to list of strings
          onTap: () async {
            context.go('/productDetail');
            /*
                      // final updatedData =
                      //     await showDialog<Map<String, dynamic>>(
                      //   context: context,
                      //   builder: (context) =>
                      //       (initialData: category),
                      // );EditCategoryDialog

                      // if (updatedData != null) {
                      //   FirebaseFirestore.instance
                      //       .collection(collectionName)
                      //       .doc(category['id'])
                      //       .update(updatedData)
                      //       .then((_) => log('Category updated successfully'))
                      //       .catchError((error) =>
                      //           log('Failed to update category: $error'));
                      // }
                      */
          },
          onPressed: () async {
            final confirmDelete = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Category'),
                content: const Text('Are you sure you want to delete ?'),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => context.pop(true),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
          brand: 'Unknown',
          rentalPrice: 0.0,
          availability: 'IN',
        );
      },
    );
  }
}
