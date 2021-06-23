import 'package:flutter/cupertino.dart';

class TransactionUtility {
  static String getFormatedAmountString(TextEditingController controller) {
    return controller.text.contains('.')
        ? getFormatedAmountDouble(controller.text).toString()
        : int.parse(controller.text).toString();
  }

  static double getFormatedAmountDouble(String _inputString) {
    if (_inputString.isEmpty) return 0;
    return double.parse(_inputString);
  }

  static bool hasCalculation(TextEditingController controller) {
    return controller.text.contains(RegExp(r'\÷|X|\-|\+'));
  }
}
