import 'package:flutter/material.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/category_list/presentation/widgets/tab_one/added_screen.dart';
import 'package:serve_mate/features/category_list/presentation/widgets/tab_two/approved_list.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

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
