import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/widgets/demo_card.dart';
import 'package:serve_mate/features/home/presentation/bloc/bloc/home_session_bloc_bloc.dart';
import 'package:serve_mate/features/home/presentation/widgets/horizontal_scroll_widget.dart';

class SessionCategorys extends StatelessWidget {
  const SessionCategorys({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCategoryBloc, SessionCategoryState>(
      builder: (context, state) {
        if (state is SessionBlocLoading) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: AppColors.orange,
              size: 50.h,
              secondRingColor: AppColors.orange,
              thirdRingColor: AppColors.grey,
            ),
          );
        }
        if (state is SessionBlocInitial) {
          
          final dynamic category = state.categoryName;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomDemoCard(category: category),
            ],
          );
        }
        log(state.toString());
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomHorizontalListWidget(
              title: "state.categoryName",
            ),
          ],
        );
      },
    );
  }
}


/*
 return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomHorizontalListWidget(
              title: categoryName,
            ), 
            CustomHorizontalListWidget(
              title: "Dresses",
            ),
            CustomHorizontalListWidget(
              title: "Decorations",
            ),
            CustomHorizontalListWidget(
              title: "Footwear",
            ),
            CustomHorizontalListWidget(
              title: "Jewelry",
            ),
            CustomHorizontalListWidget(
              title: "Sounds",
            ),
            CustomHorizontalListWidget(
              title: "Vehicles",
            ),
            CustomHorizontalListWidget(
              title: "Venues",
            ),
          ],
        );
        */