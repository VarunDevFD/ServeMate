
import 'package:serve_mate/core/error/failure.dart';

sealed class ForgetPasswordState {
  const ForgetPasswordState();
}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoadingState extends ForgetPasswordState {}

final class ForgetPasswordSuccessState extends ForgetPasswordState {}

final class ForgetPasswordFailState extends ForgetPasswordState {
  final Failure error;
  ForgetPasswordFailState({
    required this.error,
  });
}