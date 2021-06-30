import 'package:flutter/cupertino.dart';

class TransactionUtility {
  static const String operatorRegex = r'\÷|x|\-|\+';

  static String getFormatedAmountString(TextEditingController controller) {
    return controller.text.isEmpty
        ? '0'
        : getFormatedAmountDouble(controller).toString();
  }

  static double? getFormatedAmountDouble(TextEditingController controller) {
    if (controller.text.isEmpty) return 0;
    return double.tryParse(controller.text);
  }

  static bool hasCalculation(TextEditingController controller) {
    return controller.text.contains(RegExp(operatorRegex));
  }
}
