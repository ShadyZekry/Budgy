import 'package:flutter/cupertino.dart';

class TransactionUtility {
  static String getFormatedAmountString(TextEditingController controller) {
    return controller.text.contains('.')
        ? getFormatedAmountDouble(controller).toString()
        : int.parse(controller.text).toString();
  }

  static double getFormatedAmountDouble(TextEditingController controller) {
    if (controller.text.isEmpty) return 0;
    return double.parse(controller.text);
  }

  static bool hasCalculation(TextEditingController controller) {
    return controller.text.contains(RegExp(r'\÷|x|\-|\+'));
  }
}
