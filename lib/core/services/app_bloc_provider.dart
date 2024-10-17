import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:serve_mate/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:serve_mate/features/auth/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            googleSignIn: GetIt.I(),
            googleSignOut: GetIt.I(),
          ),
        ),
        BlocProvider(create: (_) => ForgetPasswordBloc()),
      ],
      child: child,
    );
  }
}
