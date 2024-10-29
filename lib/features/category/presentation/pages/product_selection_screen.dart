import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_event.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_state.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(LoadCategoriesEvent());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                "Choose a category",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Find the perfect touch to make your event\n',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'unforgettable.',
                      style: TextStyle(
                          fontWeight: FontWeight.normal), // Emphasize the word
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              Expanded(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CategoryLoaded) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(10.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the grid
                          crossAxisSpacing:
                              12.0, // Horizontal space between grid items
                          mainAxisSpacing:
                              12.0, // Vertical space between grid items
                          childAspectRatio:
                              3 / 2, // Aspect ratio for grid items
                        ),
                        itemCount: state.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          final category = state.categories[index];
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<CategoryBloc>()
                                  .add(SelectCategory(category.name));
                              context.go('/home');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(category
                                      .imageUrl), // Set the image from the category
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                      0.5), // Dark overlay for better text visibility
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Align(
                                  alignment: Alignment
                                      .bottomLeft, // Align text to bottom left
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        bottom: 8.0), // Add padding for spacing
                                    child: Text(
                                      category.name
                                          .toUpperCase(), // Display the category name
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is CategoryError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink(); // Handle unknown states
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
