import 'package:go_router/go_router.dart';
import 'package:serve_mate/features/authentication/presentation/pages/forgot_page.dart';
import 'package:serve_mate/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:serve_mate/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:serve_mate/features/naviaton/presentation/pages/bottom_nav_bar_page.dart';
import 'package:serve_mate/features/category/presentation/pages/category_select_page.dart';
import 'package:serve_mate/features/on_boarding/presentation/page/on_boarding_page/sn_onboarding.dart';
import 'package:serve_mate/features/on_boarding/presentation/page/splas_page/sn_splash.dart';
import 'package:serve_mate/features/product/presentation/pages/product_detail_page.dart';
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
        path: '/productDetail',
        builder: (context, state) {
          final category = state.extra as Map<String, dynamic>?;
          return ProductDetailPage(category: category as Map<String, dynamic>);
        },
      ),
    ],
    errorBuilder: (context, state) {
      return const WelcomeScreen(); // Redirect to a default screen (e.g., WelcomeScreen)
    },
  );
}
