import 'package:mobile_challenge/app/common/constants/app_string.dart';

class FieldValidation {
  static isEmpty(String? value) =>
      value!.isEmpty ? AppString.fieldCannotEmpty : null;

  static valueLength(String? value, int minLength) {
    final messageValidation = isEmpty(value);

    if (messageValidation == null) {
      return value!.length < minLength ? AppString.fieldCaracterLength : null;
    }

    return messageValidation;
  }
}
