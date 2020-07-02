class Functions {
  String validateEmail(String value) {
    if (value.isEmpty) {
      return "Enter email address";
    }
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'Email is not valid';
  }

  String validatePassword(String value) {
    if (value.isEmpty || value.length < 8) {
      return 'Password must be greater than 8';
    }
    return null;
  }

  String validateUsername(String value) {
    if (value.isEmpty || value.length < 5) {
      return 'Enter Username greater than 5';
    }
    return null;
  }
}
