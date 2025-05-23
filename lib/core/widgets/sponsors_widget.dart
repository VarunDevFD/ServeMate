import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/utils/bloc/sponsor_bloc/sponsor_scroller_bloc.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:animate_do/animate_do.dart';

class SponsorScroller extends StatelessWidget {
  SponsorScroller({Key? key}) : super(key: key);

  final PageController _pageController = PageController(viewportFraction: 0.6);

  @override
  Widget build(BuildContext context) {
    final sponsorNames = Names.sponsorLogos.keys.toList();
    final sponsorImages = Names.sponsorLogos.values.toList();

    return BlocProvider(
      create: (_) => SponsorScrollerBloc(itemCount: sponsorImages.length),
      child: BlocListener<SponsorScrollerBloc, SponsorScrollerState>(
        listener: (context, state) {
          _pageController.animateToPage(
            state.currentPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInLeft(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Row(
                  children: [
                    Icon(Icons.star_rounded, color: Colors.amber, size: 26.sp),
                    SizedBox(width: 10.w),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: Text(
                        "Our Sponsors",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            SizedBox(
              height: 220.h,
              child: PageView.builder(
                controller: _pageController,
                itemCount: sponsorImages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(210.r),
                            child: Image.network(
                              sponsorImages[index],
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        sponsorNames[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
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
