import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/theme/app_colors.dart';

class CategroyAddedScreen extends StatelessWidget {
  const CategroyAddedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.r), // Adjust height as needed
      child: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://raw.githubusercontent.com/VarunDevFD/ProjectImages/main/assets/images/category/vehicle_img.jpg',
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
                  text: 'Varun$index',
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
              RichText(
                text: TextSpan(
                  text: 'Place ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                  children: [
                    TextSpan(
                      text: 'location$index',
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
                    fontSize: 12.sp, // Base font size for label
                  ),
                  children: [
                    TextSpan(
                      text: '\$${100 + index}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp, // Larger font for the price
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
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
            ],
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
