class Validator {
  static String? validateUsername(String? username) {
    if(username == null) {
      return 'Username cannot be null';
    }
    if (username.isEmpty) {
      return 'Username cannot be empty';
    }
    if (username.length <= 3) {
      return 'Invalid username';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if(password == null) {
      return 'Password cannot be null';
    }
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length <= 3) {
      return 'Invalid password';
    }
    return null;
  }
}
