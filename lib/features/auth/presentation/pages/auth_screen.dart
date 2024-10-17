import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:serve_mate/features/auth/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:serve_mate/features/auth/presentation/bloc/auth_bloc/auth_state.dart';

class EmailSignInScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  EmailSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      SignInEvent(
                        _emailController.text,
                        _passwordController.text,
                      ),
                    );
              },
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      RegisterEvent(
                        _emailController.text,
                        _passwordController.text,
                      ),
                    );
              },
              child: const Text('Register'),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                } else if (state is AuthAuthenticated) {
                  return Text('Welcome ${state.user.email}');
                } else if (state is AuthError) {
                  return Text('Error: ${state.message}');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
