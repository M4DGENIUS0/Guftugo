class Validation {
  // check email format like 00@gmail.com
  bool emailValidator(String email) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
    return emailValid;
  }

  // for Password Pattern
  List<String> passwordValidator(String password) {
    List<String> errors = [];

    // Check for uppercase letters
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add("At least one uppercase letter is required.");
    }

    // Check for lowercase letters
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add("At least one lowercase letter is required.");
    }

    // Check for numeric digits
    if (!RegExp(r'\d').hasMatch(password)) {
      errors.add("At least one numeric digit is required.");
    }

    // Check for special characters
    if (!RegExp(r'[@$!%*?&]').hasMatch(password)) {
      errors.add(
          "At least one special character (@, \$, !, %, *, ?, &) is required.");
    }

    // Check for minimum length
    if (password.length < 8) {
      errors.add("Password must be at least 8 characters long.");
    }

    return errors;
  }

  // Name format check
  List<String> nameValidator(String name) {
    List<String> errors = [];
    // Check if the name is empty
    if (name.isEmpty) {
      errors.add("Name cannot be empty.");
    }

    // Ensure the name contains only letters and spaces
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
      errors.add(
          "Name can only contain letters and spaces.\nNo numbers or special characters are allowed.");
    }

    // Restrict the length of the name to avoid large sentences
    if (name.length > 50) {
      errors.add("Name is too long. Please enter a shorter name.");
    }
    if (name.length < 3) {
      errors.add("Name is too Short. Please enter a valid name.");
    }

    // Restrict the number of words (e.g., maximum of 3 words)
    if (name.split(" ").length > 3) {
      errors.add(
          "Name is too complex.\nPlease enter your first name and last name only.");
    }

    return errors;
  }
}
