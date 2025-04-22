class Helpers {
  static String concatenateWithNewEmail(String email, {String role = "S"}) {
    return "$role$email";
  }

  static String splitEmail(String email) {
    return email.substring(1);
  }
}