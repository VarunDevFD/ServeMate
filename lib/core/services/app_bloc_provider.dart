import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/toggle_bloc/toggle_bloc_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/onboarding_bloc/onboarding_bloc.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/splash_bloc/splash_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => OnboardingCubit()),
        BlocProvider(create: (_) => TogglePasswordBloc()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => ForgetPasswordBloc()),
        BlocProvider(create: (_) => CategoryBloc()),
      ],
      child: child,
    );
  }
}