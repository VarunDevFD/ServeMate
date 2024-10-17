import 'package:flutter/material.dart';
import 'package:serve_mate/core/services/router.dart';
import 'core/services/app_bloc_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      // Import the Global MultiBlocProvider
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router, // Use the router instance
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
