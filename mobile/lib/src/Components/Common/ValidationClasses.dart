import 'package:form_field_validator/form_field_validator.dart';

//Alphabetical. List of field validators.

class EmailFieldValidator {
  static String? validate(String value) {
    final emailValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
      EmailValidator(errorText: "Invalid email address"),
    ]);

    return !emailValidator.isValid(value) ? emailValidator.errorText : null;
  }
}

class FirstNameFieldValidator {
  static String? validate(String value) {
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
  static String? validate(String value) {
    final lastNameValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
      LengthRangeValidator(min: 8, max: 20, errorText: 'Invalid name')
    ]);

    return !lastNameValidator.isValid(value)
        ? lastNameValidator.errorText
        : null;
  }
}

//TODO dropdown validator
class OrgTypeFieldValidator {
  static String? validate(String value) {}
}

class PasswordFieldValidator {
  static String? validate(String value) {
    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
      MinLengthValidator(8, errorText: "Invalid password"),
      PatternValidator(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
          errorText: "Invalid password"), //Digits only
    ]);

    return !passwordValidator.isValid(value)
        ? passwordValidator.errorText
        : null;
  }
}

class UsernameFieldValidator {
  static String? validate(String value) {
    final usernameValidator = MultiValidator([
      RequiredValidator(errorText: "* Required"),
      LengthRangeValidator(min: 8, max: 20, errorText: 'Invalid username')
    ]);

    return !usernameValidator.isValid(value)
        ? usernameValidator.errorText
        : null;
  }
}

//TODO dropdown validator
class UserTypeFieldValidator {
  static String? validate(String value) {}
}
