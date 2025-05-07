import 'package:flutter/material.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
<<<<<<< HEAD
import 'package:serve_mate/features/category_list/presentation/widgets/tab_one/list_category.dart';
import 'package:serve_mate/features/category_list/presentation/widgets/tab_two/approved_list.dart';

class ListPage extends StatelessWidget {
  final String type;
  ListPage({super.key, required this.type});
=======
import 'package:serve_mate/features/category_list/presentation/widgets/tab_one/added_screen.dart';
import 'package:serve_mate/features/category_list/presentation/widgets/tab_two/approved_list.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});
>>>>>>> da7540b6fe015c2e30fe6801e13ffa3fa9821d0e

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
<<<<<<< HEAD
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
=======
                dividerColor: AppColors.dimBlack,
                indicatorColor: AppColors.orange,
                unselectedLabelColor: AppColors.grey,
                tabs: const [
                  Tab(text: 'Added Category'),
                  Tab(text: 'Approved List'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    CategroyAddedScreen(),
                    CategoryApprovedScreen(),
>>>>>>> da7540b6fe015c2e30fe6801e13ffa3fa9821d0e
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
