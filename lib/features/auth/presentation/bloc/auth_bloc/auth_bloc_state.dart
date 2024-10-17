import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';


abstract class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object?> get props => []; // Default empty props for base class
}

class AuthInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class Authenticated extends AuthBlocState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user]; // Compare based on the user
}

class SignOutSuccessState extends AuthBlocState {}

class AuthError extends AuthBlocState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message]; // Compare based on the error message
}

class Unauthenticated extends AuthBlocState {}



