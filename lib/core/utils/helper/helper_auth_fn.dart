class Helpers {
  static String concatenateWithNewEmail(String email, {String role = "S"}) {
    return "$role$email";
  }

  static String splitEmail(String email) {
    return email.substring(1);
  }

  static String capitalizeFirstLetter(String word) {
  if (word.isEmpty) return word;
  return word[0].toUpperCase() + word.substring(1);
}

}