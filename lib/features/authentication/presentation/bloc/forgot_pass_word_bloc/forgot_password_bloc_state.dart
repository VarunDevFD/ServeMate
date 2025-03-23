import 'package:serve_mate/core/error/failure.dart';

class ForgetPasswordState {
  const ForgetPasswordState();
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {}

class ForgetPasswordFailure extends ForgetPasswordState {
  final Failure error;
  const ForgetPasswordFailure({required this.error});
}