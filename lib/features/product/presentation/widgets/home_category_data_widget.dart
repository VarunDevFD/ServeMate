import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_page_category_cards.dart';

class HomeCategoryDataWidget extends StatelessWidget {
  const HomeCategoryDataWidget({super.key});

  // Fetch category from preferences
  Future<String?> _getCategoryFromPref() async {
    final prefs = serviceLocator<PreferencesRepository>();
    return prefs.getDataFn();
  }

  // Fetch category data from Firestore
  Future<List<Map<String, dynamic>>> fetchCategoryData() async {
    try {
      final collectionName = await _getCategoryFromPref();
      if (collectionName == null) {
        throw Exception("Category not found in preferences.");
      }

      final snapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      // Convert Firestore documents to a list of maps
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchCategoryData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // String formattedDate = DateTime.now().toString();

            return Center(
              child: CategoryCards(
                /*
                // imageUrl: 'assets/images/category/vehicle_img.jpg',
                // date: formattedDate,*/
                onTap: () {},
                name: 'Sample Vehicle',
                brand: 'Toyota',
                rentalPrice: 200.0,
                availability: 'Available',
              ),
            );
          }

          final data = snapshot.data!;
          /* log("--------------------------${data.toString()}------------------");*/
          return FutureBuilder<String?>(
            future: _getCategoryFromPref(),
            builder: (context, collectionSnapshot) {
              if (collectionSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (collectionSnapshot.hasError) {
                return Center(
                  child: Text(
                      'Error fetching collection name: ${collectionSnapshot.error}'),
                );
              } else if (!collectionSnapshot.hasData) {
                return const Center(child: Text('Collection name not found.'));
              }

              final collectionName = collectionSnapshot.data!;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final category = data[index];

                  return CategoryCards(
                    name: category['name'] ?? 'Unknown',
                    // details: (category['details'] as List<dynamic>?)
                    //         ?.map((e) => e.toString())
                    //         .toList() ??
                    //     [], // Converts category details to list of strings
                    onTap: () async {
                      context.go('/productDetail', extra: category);
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
                          content: Text(
                              'Are you sure you want to delete "${category['name']}"?'),
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

                      if (confirmDelete == true) {
                        FirebaseFirestore.instance
                            .collection(collectionName)
                            .doc(category['id'])
                            .delete()
                            .then((_) => log('Category deleted successfully'))
                            .catchError((error) =>
                                log('Failed to delete category: $error'));
                      }
                    },
                    brand: category['brand'] ?? 'Unknown',
                    rentalPrice: category['rentalPrice'] ?? 0.0,
                    availability: category['availability'] ?? 'IN',
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
