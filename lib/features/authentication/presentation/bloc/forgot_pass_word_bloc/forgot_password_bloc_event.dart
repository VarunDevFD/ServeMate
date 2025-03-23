class ForgetPasswordEvent {
  const ForgetPasswordEvent();
}

class SendPasswordResetEmail extends ForgetPasswordEvent {
  final String email;
  const SendPasswordResetEmail({required this.email});
}