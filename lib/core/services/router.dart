import 'package:go_router/go_router.dart';
import 'package:serve_mate/features/auth/presentation/pages/auth_screen.dart';
import 'package:serve_mate/features/auth/presentation/pages/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => EmailSignInScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  redirect: (context, state) {
    // Add any redirection logic here if needed (e.g., checking user auth status)
    return null; // Modify as needed
  },
);
