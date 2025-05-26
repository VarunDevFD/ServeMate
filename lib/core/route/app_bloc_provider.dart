import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/category_list/presentation/bloc/category_home_two/h2_category_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/bloc_home/home_session_bloc_bloc.dart';
import 'package:serve_mate/features/home/presentation/bloc/bloc_search/search_bloc.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/animation_bloc/animation_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/calender_bloc/calender_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/dress_bloc/dress_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/filter_chip_cubit/filter_chip_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/form_submission_bloc/form_submission_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/image_bloc/image_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/item_bloc/item_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:serve_mate/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/toggle_bloc/toggle_bloc_bloc.dart';
import 'package:serve_mate/features/on_boarding/presentation/bloc/onboarding_bloc/onboarding_bloc.dart';
import 'package:serve_mate/features/naviaton/presentation/cubit/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:serve_mate/features/authentication/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_bloc.dart';
import 'package:serve_mate/features/product/presentation/bloc/switch_cubit/cubit/available_switch_cubit.dart';
import 'package:serve_mate/features/product/presentation/bloc/tab_toggle_button.dart/bloc.dart';
import 'package:serve_mate/features/profile/presentation/bloc/profile_bloc/profile_bloc_bloc.dart';

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
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider(create: (_) => DressFormBloc()),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => DateBloc()),
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => SearchBarBloc()),
        BlocProvider(create: (_) => CommonBloc()),
        BlocProvider(create: (_) => AddProductBloc()),
        BlocProvider(create: (_) => AvailableSwitchCubit()),
        BlocProvider(create: (_) => CheckBoxCubit()),
        BlocProvider(create: (_) => FilterChipCubit()),
        BlocProvider(create: (_) => ImagePickerBloc()),
        BlocProvider(create: (_) => serviceLocator<ProfileBloc>()),
        BlocProvider(create: (_) => H2CategoryBloc()),
        BlocProvider(create: (_) => SessionCategoryBloc()),
        BlocProvider(create: (_) => SearchBloc()),
      ],
      child: child,
    );
  }
}
