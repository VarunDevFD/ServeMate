import 'package:flutter/material.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/category_list/presentation/widgets/tab_one/list_category.dart';
import 'package:serve_mate/features/category_list/presentation/widgets/tab_two/approved_list.dart';

class ListPage extends StatelessWidget {
  final String type;
  ListPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                labelColor: AppColors.orange,
                unselectedLabelColor: AppColors.grey,
                indicatorColor: AppColors.orange,
                tabs: [
                  Tab(text: '$type List'),
                  const Tab(text: 'Approved List'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    CategroyAddedScreen(categoryName: type),
                    const CategoryApprovedScreen(),
                    // EmptyScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
