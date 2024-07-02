import 'package:flutter/services.dart';

class TimeFormatter extends TextInputFormatter {
  TimeFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 4) {
      return oldValue;
    }

    String newText = newValue.text;
    if (newText.length > 2) {
      newText = '${newText.substring(0, 2)}:${newText.substring(2)}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
