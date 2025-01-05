import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_image_widget.dart';
import 'package:serve_mate/features/product/presentation/widgets/home_page_category_cards.dart';
import 'package:serve_mate/features/product/presentation/widgets/search_field_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<String?> _getCategoryFromPref() async {
    final PreferencesRepository prefs = serviceLocator<PreferencesRepository>();
    return prefs.getDataFn();
  }

  Future<List<Map<String, dynamic>>> fetchCategoryData() async {
    try {
      final collectionName = await _getCategoryFromPref();
      if (collectionName == null) {
        throw Exception("Category not found in Collection Name.");
      }

      return await fetchFromFirestore<Map<String, dynamic>>(
        category: collectionName,
        fromMap: (map) => map,
      );
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<List<T>> fetchFromFirestore<T>({
    required String category,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      log(category);
      final snapshot =
          await FirebaseFirestore.instance.collection(category).get();
      return snapshot.docs.map((doc) => fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch data from $category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                      return const Center(child: Text('Error fetching data.'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // Show a default card if no data is available
                      return Center(
                        child: CategoryCards(
                          imageUrl: 'https://example.com/default-image.jpg',
                          title: 'No Category',
                          details: const ['No data available.'],
                          onTap: () {},
                        ),
                      );
                    }

                    final data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final category = data[index];
                        return CategoryCards(
                          // imageUrl: category['imageUrl'],
                          title: category['name'],
                          // details: (category['details'] as List<dynamic>)
                          //     .map((e) => e.toString())
                          //     .toList(),
                          onTap: () {
                            log('Tapped on ${category['title']}');
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
