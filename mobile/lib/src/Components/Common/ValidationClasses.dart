import 'package:form_field_validator/form_field_validator.dart';

//Alphabetical. List of field validators.

class EmailFieldValidator {
  static String? validate(String? value) {
    final emailValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
      EmailValidator(errorText: "Invalid email address"),
    ]);

    return !emailValidator.isValid(value) ? emailValidator.errorText : null;
  }
}

class FirstNameFieldValidator {
  static String? validate(String? value) {
    final firstNameValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
      LengthRangeValidator(min: 8, max: 20, errorText: 'Invalid name')
    ]);

    return !firstNameValidator.isValid(value)
        ? firstNameValidator.errorText
        : null;
  }
}

class LastNameFieldValidator {
  static String? validate(String? value) {
    final lastNameValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
      LengthRangeValidator(min: 8, max: 20, errorText: 'Invalid name')
    ]);

    return !lastNameValidator.isValid(value)
        ? lastNameValidator.errorText
        : null;
  }
}

class OrgTypeFieldValidator {
  static String? validate(String? value) {
    final orgTypeValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
    ]);
    if (value == 'Select an organisation') return '* Required';
    return !orgTypeValidator.isValid(value) ? orgTypeValidator.errorText : null;
  }
}

class PasswordFieldValidator {
  static String? validate(String? value) {
    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
      MinLengthValidator(8, errorText: "Invalid password"),
      PatternValidator(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
          errorText: "Invalid password"),
    ]);
    if (value == 'Select a user type') return '* Required';
    return !passwordValidator.isValid(value)
        ? passwordValidator.errorText
        : null;
  }
}

class UsernameFieldValidator {
  static String? validate(String? value) {
    final usernameValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
      LengthRangeValidator(min: 4, max: 20, errorText: 'Invalid username')
    ]);

    return !usernameValidator.isValid(value)
        ? usernameValidator.errorText
        : null;
  }
}

class UserTypeFieldValidator {
  static String? validate(String? value) {
    final userTypeValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
    ]);

    if (value == 'Select a user type') return '* Required';
    return !userTypeValidator.isValid(value)
        ? userTypeValidator.errorText
        : null;
  }
}
