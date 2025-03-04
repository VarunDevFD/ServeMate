import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/route/router.dart';
import 'package:serve_mate/core/theme/app_theme.dart';
import 'core/route/app_bloc_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      // Import the Global MultiBlocProvider
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            title: 'Serve Mate',
            theme: AppTheme.buildWeddingTheme(),
          );
        },
      ),
    );
  }
}
