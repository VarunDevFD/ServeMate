import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/services/injection_container.dart';
import 'package:serve_mate/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
// Import other blocs here

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => serviceProvider<AuthBloc>()),
        // BlocProvider<BookingBloc>(
        //     create: (_) => serviceProvider<BookingBloc>()),
        // Add other blocs here
      ],
      child: child,
    );
  }
}
