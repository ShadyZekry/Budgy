import 'package:flutter/cupertino.dart';

class TransactionUtility {
  static const String _operatorRegex = r'\÷|x|\-|\+';

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
    return controller.text.contains(RegExp(_operatorRegex));
  }

  static void performCalculation(TextEditingController controller) {
    int operatorIndex = controller.text.indexOf(RegExp(_operatorRegex));
    double a = double.parse(controller.text.substring(0, operatorIndex));
    double b = double.parse(controller.text.substring(operatorIndex + 1));

    double? result;

    switch (controller.text[operatorIndex]) {
      case '÷':
        result = _performDivision(controller, a, b);
        break;
      case 'x':
        result = _performMultiplication(controller, a, b);
        break;
      case '-':
        result = _performSubtraction(controller, a, b);
        break;
      case '+':
        result = _performAddition(controller, a, b);
        break;
      default:
        return;
    }

    if (result == null) return;

    if (result - result.floor() == 0)
      controller.text = result.toInt().toString();
    else
      controller.text = result.toString();
  }

  static double? _performDivision(
      TextEditingController controller, double a, double b) {
    if (b == 0) return null;
    return a / b;
  }

  static double _performMultiplication(
          TextEditingController controller, double a, double b) =>
      a * b;
  static double? _performSubtraction(
      TextEditingController controller, double a, double b) {
    if (a < b) return null;
    return a - b;
  }

  static double _performAddition(
          TextEditingController controller, double a, double b) =>
      a + b;
}
