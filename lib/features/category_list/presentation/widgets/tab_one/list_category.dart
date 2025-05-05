import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_event.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_state.dart';
import '../../bloc/category_home_two/h2_category_bloc.dart';

class CategroyAddedScreen extends StatelessWidget {
  final String? categoryName;
  CategroyAddedScreen({super.key, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<H2CategoryBloc, H2CategoryState>(
      builder: (context, state) {
        if (state is H2CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is H2CategoryError) {
          return Center(
              child: Text(
            state.message,
            style: TextStyle(color: AppColors.red),
          ));
        } else if (state is CameraCategoryLoaded) {
          return _buildList(state.categories);
        } else if (state is DecorationCategoryLoaded) {
          return _buildList(state.categories);
        } else if (state is DressCategoryLoaded) {
          return _buildList(state.categories);
        } else if (state is FootwearCategoryLoaded) {
          return _buildList(state.categories);
        } else if (state is JewelryCategoryLoaded) {
          return _buildList(state.categories);
        } else if (state is SoundCategoryLoaded) {
          return _buildList(state.categories);
        } else if (state is VehiclesCategoryLoaded) {
          return _buildList(state.categories);
        } else if (state is VenuesCategoryLoaded) {
          return _buildList(state.categories);
        } else {
          return const Center(child: Text('Select a category'));
        }
      },
    );
  }

  Widget _buildList(List<dynamic> categories) {
    return Padding(
      padding: EdgeInsets.all(6.r),
      child: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = categories[index];

          final images = item.images[0] + item.images[1];
          final location = item.location[0];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                images ?? 'https://via.placeholder.com/50',
                width: 50.w,
                height: 60.h,
                fit: BoxFit.cover,
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: 'Name: ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: item.name ?? 'N/A', // Use actual name from model
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (location != null) // Check if place exists in model
                  RichText(
                    text: TextSpan(
                      text: 'Place ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                      children: [
                        TextSpan(
                          text: location ?? 'N/A',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                RichText(
                  text: TextSpan(
                    text: 'Price: ',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 12.sp,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '₹${item.price ?? 'N/A'}', // Use actual price from model
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.av_timer_outlined,
                      color: AppColors.yellow,
                    ),
                    Text('Pending...',
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.red,
                  ),
                  onPressed: () {
                    showDialog(
                      context:
                          context, // Make sure you have access to the context here
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Category'),
                        content: const Text('Are you sure you want to delete?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<H2CategoryBloc>()
                                  .add(DeleteCategoryEvent(item.id));
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
            isThreeLine: true,
            onTap: () {
              context.read<H2CategoryBloc>().add(SelectCategoryItemEvent(item));
              context.push('/detailsPage');
            },
          );
        },
      ),
    );
  }
}
