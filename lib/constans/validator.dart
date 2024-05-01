class Validators{
  static String? displayNameValidator(String? displayName){
    if(displayName == null || displayName.isEmpty){
      return 'Display name cannot be empty';
    }
    else if(displayName.length < 3 || displayName.length > 20){
      return 'Display name must be between 3 and 20 characters';
    }
  }
  static String? emailValidator(String email){
    if(email == null || email.isEmpty){
      return 'please enter an email';
    }
    /*if(!RegExp(r'\b[A-Za-z0-9.%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(email)){
      return 'please enter a valid email';
    }*/
    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
      return 'please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String password){
    if(password == null || password.isEmpty){
      return 'please enter an password';
    }
    if(password.length < 6){
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? passwordAgainValidator(String password,String passwordAgain){
    if(password == null || password.isEmpty){
      return 'please enter an password';
    }
    else if(password == passwordAgain){
      return 'Passwords do not match';
    }
    return null;
  }
}