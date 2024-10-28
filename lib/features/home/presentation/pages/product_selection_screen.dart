import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/category_bloc/category_event.dart';
import 'package:serve_mate/features/home/presentation/bloc/category_bloc/category_state.dart';
import 'package:serve_mate/features/home/presentation/pages/category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Choose a Category',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: WeddingCategory.values.length,
                    itemBuilder: (context, index) {
                      final category = WeddingCategory.values[index];
                      return GestureDetector(
                        onTap: () {
                          // Trigger the SelectCategory event
                          BlocProvider.of<CategoryBloc>(context)
                              .add(SelectCategory(category));
                          // Navigate to HomePage after selecting category
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              category.toString().split('.').last.toUpperCase(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
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
