import 'package:go_router/go_router.dart';
import 'package:serve_mate/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:serve_mate/features/auth/presentation/pages/sign_up_screen.dart';
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
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => SignUpScreen(),
      ),
      // GoRoute(
      //   path: '/home',
      //   builder: (context, state) => const HomeScreen(),
      // ),
      // GoRoute(
      //   path: '/forgotPassword',
      //   builder: (context, state) => ForgotPasswordScreen(),
      // ),
      // GoRoute(
      //   path: '/home',
      //   builder: (context, state) => const HomeScreen(),
      // ),
    ],
  );
}
