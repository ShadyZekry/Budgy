import 'package:flutter/cupertino.dart';

class TransactionUtility {
  static String getFormatedAmountString(TextEditingController _textController) {
    return _textController.text.contains('.')
        ? getFormatedAmountDouble(_textController).toString()
        : int.parse(_textController.text).toString();
  }

  static double getFormatedAmountDouble(TextEditingController _textController) {
    return double.parse(_textController.text);
  }
}
