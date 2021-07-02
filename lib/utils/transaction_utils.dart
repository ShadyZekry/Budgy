import 'package:flutter/cupertino.dart';

class TransactionRepository {
  static final RegExp operatorRegex = RegExp(r'\÷|x|\-|\+');

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
    return controller.text.contains(operatorRegex);
  }

  // void _removeLastValueFromResult() {
  //   if (!_shouldRemoveFromInput) return;

  //   if (textController.text.length == 1)
  //     textController.text = '0';
  //   else
  //     textController.text =
  //         textController.text.substring(0, textController.text.length - 1);
  // }

  // bool get _shouldRemoveFromInput {
  //   return textController.text.isNotEmpty &&
  //       (double.tryParse(textController.text) == null ||
  //           double.parse(textController.text) > 0);
  // }

  static String performCalculation(String input) {
    int operatorIndex = input.indexOf(operatorRegex);
    double a = double.parse(input.substring(0, operatorIndex));
    double b = double.parse(input.substring(operatorIndex + 1));

    double? result;

    switch (input[operatorIndex]) {
      case '÷':
        result = _performDivision(a, b);
        break;
      case 'x':
        result = _performMultiplication(a, b);
        break;
      case '-':
        result = _performSubtraction(a, b);
        break;
      case '+':
        result = _performAddition(a, b);
        break;
      default:
        return input;
    }

    if (result == null) return input;

    if (result - result.floor() == 0)
      return result.toInt().toString();
    else
      return result.toString();
  }

  static double? _performDivision(double a, double b) {
    if (b == 0) return null;
    return a / b;
  }

  static double _performMultiplication(double a, double b) => a * b;
  static double? _performSubtraction(double a, double b) {
    if (a < b) return null;
    return a - b;
  }

  static double _performAddition(double a, double b) => a + b;
}
