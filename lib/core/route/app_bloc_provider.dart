import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/animation_bloc/animation_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dropdown_bloc/dropdown_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/venues_bloc/venues_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/toggle_bloc/toggle_bloc_bloc.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/onboarding_bloc/onboarding_bloc.dart';
import 'package:serve_mate/features/bottom_navigation_bar/presentation/bloc/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_bloc.dart';

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
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => DressFormBloc()),
        BlocProvider(create: (_) => ImageBloc()),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => DropdownBloc()),
        BlocProvider(create: (_) => DateBloc()),
        BlocProvider(create: (_) => VenueFormBloc()),
        BlocProvider(create: (_) => TabTogglCubit()),
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => SearchBarBloc()),
      ],
      child: child,
    );
  }
}
