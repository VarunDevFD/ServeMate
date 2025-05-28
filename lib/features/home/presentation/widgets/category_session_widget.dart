import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/helper/helper_auth_fn.dart';
import 'package:serve_mate/core/widgets/demo_card.dart';
import 'package:serve_mate/features/home/presentation/bloc/bloc_home/home_session_bloc_bloc.dart';
import 'package:serve_mate/features/home/presentation/widgets/button_venues_more.dart';
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
        if (state is SessionBlocLoaded) { 
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: state.minHeight ?? 280.h,
              maxHeight: state.maxHeight ?? 1560.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 8.w),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: state.data.length,
                separatorBuilder: (context, index) {
                  String title = Helpers.capitalizeFirstLetter(
                      state.data.keys.elementAt(index));
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child:
                          (state.data[state.data.keys.elementAt(index)].length >
                                  1)
                              ? MoreVenuesButton(title: title)
                              : SizedBox(height: 5.h));
                },
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: state.minHeight,
                    child: CustomHorizontalListWidget(
                      dataName: state.data.keys.elementAt(index),
                      dataValue: state.data[state.data.keys.elementAt(index)],
                    ),
                  );
                },
              ),
            ),
          );
        }
        log(state.toString());
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomHorizontalListWidget(
                dataName: "state.categoryName", dataValue: const [10, 12]),
          ],
        );
      },
    );
  }
}
