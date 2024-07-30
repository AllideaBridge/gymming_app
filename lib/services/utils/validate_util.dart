import 'package:gymming_app/common/constants.dart';

class ValidateUtil {
  static bool isPhoneNumberValid(String input) {
    List<String> numbers = input.split("-");
    if (numbers.isEmpty || numbers.length != 3) {
      return false;
    }

    if (!FIRST_NUMBERS.contains(numbers[0])) {
      return false;
    }

    if (numbers[1].length != 4 || numbers[2].length != 4) {
      return false;
    }
    return true;
  }
}
