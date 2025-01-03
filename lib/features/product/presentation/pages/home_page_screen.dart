import 'dart:async';

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

  // Fetch category data from preferences
  Future<String?> _getCategoryFromPref() async {
    final PreferencesRepository prefs = serviceLocator<PreferencesRepository>();
    return prefs
        .getDataFn(); // Replace with your preference key function if needed
  }

  // Fetch category data from Firestore
  Future<List<Map<String, dynamic>>> fetchCategoryData() async {
    try {
      final category =
          await _getCategoryFromPref(); // Fetch category from preferences
      if (category == null) {
        throw Exception("Category not found in preferences.");
      }

      final snapshot = await FirebaseFirestore.instance
          .collection(category)
          .get(); // Fetch category data from Firestore
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
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
                        title: 'Default Category',
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
                        imageUrl: category['imageUrl'],
                        title: category['title'],
                        details: (category['details'] as List<dynamic>)
                            .map((e) => e.toString())
                            .toList(),
                        onTap: () {
                          debugPrint('Tapped on ${category['title']}');
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
    );
  }
}
