import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/product/presentation/pages/editing_page.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_image_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_page_category_cards.dart';
import 'package:serve_mate/features/product/presentation/widgets/search_field_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              const AnimatedSearchBar(),
              SizedBox(height: 20.h),
              ImageCarousel(),
              SizedBox(height: 20.h),
              Expanded(
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
                      String formattedDate = DateTime.now().toString();

                      return Center(
                        child: CategoryCards(
                          imageUrl: 'assets/images/category/vehicle_img.jpg',
                          title: 'No Category',
                          details: const ['No data available.'],
                          onTap: () {},
                          action: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.info_outline),
                                onPressed: () {
                                  log('Info button pressed for No Category');
                                },
                              ),
                            ],
                          ),
                          // Add the required parameters
                          name: 'Sample Vehicle',
                          vehicleType: 'Car',
                          brand: 'Toyota',
                          color: 'Red',
                          rentalPrice: 200.0,
                          securityDeposit: 500.0,
                          date: formattedDate,
                          images: const [
                            'assets/images/category/vehicle_img.jpg',
                            'assets/images/category/vehicle_img.jpg'
                          ],
                          location: 'New York, NY',
                          availability: 'Available',
                        ),
                      );
                    }

                    final data = snapshot.data!;
                    return FutureBuilder<String?>(
                      future: _getCategoryFromPref(),
                      builder: (context, collectionSnapshot) {
                        if (collectionSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (collectionSnapshot.hasError) {
                          return Center(
                            child: Text(
                                'Error fetching collection name: ${collectionSnapshot.error}'),
                          );
                        } else if (!collectionSnapshot.hasData) {
                          return const Center(
                              child: Text('Collection name not found.'));
                        }

                        final collectionName = collectionSnapshot.data!;

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final category = data[index];

                            return CategoryCards(
                              title: category['name'] ??
                                  'Unknown', // Title of the category, default to 'Unknown'
                              details: (category['details'] as List<dynamic>?)
                                      ?.map((e) => e.toString())
                                      .toList() ??
                                  [], // Converts category details to list of strings
                              onTap: () {
                                log('Tapped on ${category['name']}'); // Action on tap (you can customize this)
                              },
                              action: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Edit button
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () async {
                                      final updatedData = await showDialog<
                                          Map<String, dynamic>>(
                                        context: context,
                                        builder: (context) =>
                                            EditCategoryDialog(
                                                initialData: category),
                                      );

                                      if (updatedData != null) {
                                        FirebaseFirestore.instance
                                            .collection(collectionName)
                                            .doc(category['id'])
                                            .update(updatedData)
                                            .then((_) => log(
                                                'Category updated successfully'))
                                            .catchError((error) => log(
                                                'Failed to update category: $error'));
                                      }
                                    },
                                  ),
                                  // Delete button
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () async {
                                      final confirmDelete =
                                          await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Delete Category'),
                                          content: Text(
                                              'Are you sure you want to delete "${category['name']}"?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
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
                                            .then((_) => log(
                                                'Category deleted successfully'))
                                            .catchError((error) => log(
                                                'Failed to delete category: $error'));
                                      }
                                    },
                                  ),
                                ],
                              ),
                              // Passing additional details to CategoryCards
                              name: category['name'] ??
                                  'Unknown', // Name of the category
                              vehicleType: category['vehicleType'] ?? 'Unknown',
                              brand: category['brand'] ?? 'Unknown',
                              color: category['color'] ?? 'Unknown',
                              rentalPrice: category['rentalPrice'] ?? 0.0,
                              securityDeposit:
                                  category['securityDeposit'] ?? 0.0,
                              date: category['date'] ?? 'Unknown',

                              images:
                                  List<String>.from(category['images'] ?? []),
                              location: category['location'] ?? 'Unknown',
                              availability:
                                  category['availability'] ?? 'Unknown',
                              description: category[
                                  'description'], // Optional, it may or may not be available
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
