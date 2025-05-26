import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_mate/core/common/screens/product_details_page.dart';
import 'package:serve_mate/core/common/screens/update_screen.dart';
import 'package:serve_mate/features/authentication/presentation/pages/forgot_page.dart';
import 'package:serve_mate/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:serve_mate/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:serve_mate/features/home/presentation/pages/search_page.dart';
import 'package:serve_mate/features/naviaton/presentation/pages/bottom_nav_bar_page.dart';
import 'package:serve_mate/features/category/presentation/pages/category_select_page.dart';
import 'package:serve_mate/features/on_boarding/presentation/page/on_boarding_page/sn_onboarding.dart';
import 'package:serve_mate/features/on_boarding/presentation/page/splas_page/sn_splash.dart';
import 'package:serve_mate/features/welcome/presentation/page/s_welcome.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => SignInPage(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => ForgotPasswordpage(),
      ),
      GoRoute(
        path: '/selectCategory',
        builder: (context, state) => const CategorySelectionPage(),
      ),
      GoRoute(
        path: '/bottomNavBar',
        builder: (context, state) => BottomNavigationBar(),
      ),
      GoRoute(
        path: '/detailsPage',
        builder: (context, state) => const CategoryDetailsScreen(),
      ),
      GoRoute(
        path: '/editCategoryPage',
        builder: (context, state) => const UpdatePage(),
      ),
      GoRoute(
        path: '/search',
        pageBuilder: (context, state) =>
            fadeTransitionPage(  SearchPage(), state),
      ),

      // GoRoute(
      //   path: '/productDetail',
      //   builder: (context, state) {
      //     final category = state.extra as Map<String, dynamic>?;
      //     return ProductDetailPage(category: category as Map<String, dynamic>);
      //   },
      // ),
    ],
    errorBuilder: (context, state) {
      return const WelcomeScreen(); // Redirect to a default screen (e.g., WelcomeScreen)
    },
  );
}

Page<dynamic> fadeTransitionPage(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Animate fade out of the old screen and fade in of the new screen simultaneously
      return FadeTransition(
        opacity: animation,
        child: FadeTransition(
          opacity: ReverseAnimation(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}
