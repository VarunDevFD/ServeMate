import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/core/utils/helper/helper_auth_fn.dart';
import 'package:serve_mate/core/utils/helper/image_concatinate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_event.dart';

class CustomHorizontalListWidget extends StatelessWidget {
  final String dataName;
  final List<dynamic> dataValue;
  CustomHorizontalListWidget({
    Key? key,
    required this.dataName,
    required this.dataValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = Helpers.capitalizeFirstLetter(dataName);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dataValue.length,
              itemBuilder: (context, index) {
                final item = dataValue[index];
                final imageUrl = ImageConcatinate.concatinateImage(item.images);
                return Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<H2CategoryBloc>()
                          .add(DetailsEvent(dataName, item, false));

                      context.push('/detailsPage');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150.h,
                          width: 200.w,
                          child: Image.network(
                            imageUrl[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 8.w, top: 8.w, right: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.location[0],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '₹',
                                        style: TextStyle(
                                          height: 1.3.h,
                                          fontSize: 14.sp,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${item.price}',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' per day',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
