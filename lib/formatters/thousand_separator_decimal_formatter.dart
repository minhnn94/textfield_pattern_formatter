import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:textfield_pattern_formatter/extensions/strings_extension.dart';

class ThousandSeparatorDecimalFormatter extends TextInputFormatter {
  final formatter = NumberFormat(
    '#,###.##',
  );
  final int decimalDigits;

  ThousandSeparatorDecimalFormatter({this.decimalDigits = 2});
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String truncated = newValue.text;
    TextSelection newSelection = newValue.selection;
    if (isDuplicateDotOrComma(oldValue.text, newValue.text)) {
      return oldValue;
    } else if (isInputTypingStatus(truncated)) {
      return newValue;
    } else if (truncated.endsWith(",")) {
      truncated = formatStringEndWithCommaToDot(truncated);
    } else {
      String content = getContentAndFilterDecimals(truncated);
      final value = double.tryParse(content.reverseFromMoney);
      truncated = formatter.format(value);
    }
    newSelection =
        TextSelection.fromPosition(TextPosition(offset: truncated.length));
    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }

  bool isInputTypingStatus(String text) {
    return text.endsWith(".") || text.isEmpty || text.endsWith(".0");
  }

  String getContentAndFilterDecimals(String content) {
    int sumOfDecimals = getSumOfDecimalDigits(content);
    if (sumOfDecimals > decimalDigits) {
      content = content.substring(0, content.length - 1);
    }
    return content;
  }

  int getSumOfDecimalDigits(String content) {
    int indexDecimal = content.indexOf('.');
    if (indexDecimal == -1) {
      return 0;
    } else {
      int sumOfDecimals = content.length - 1 - indexDecimal;
      return sumOfDecimals;
    }
  }

  bool isDuplicateDotOrComma(String oldValue, String newValue) {
    return newValue.length > oldValue.length &&
        oldValue.contains('.') &&
        isInputNewDotOrComma(newValue);
  }

  bool isInputNewDotOrComma(String content) {
    return content.endsWith('.') || content.endsWith(',');
  }

  String formatStringEndWithCommaToDot(String text) {
    text = text.substring(0, text.length - 1);
    text += '.';
    return text;
  }
}
