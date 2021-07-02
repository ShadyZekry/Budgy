import 'package:flutter/cupertino.dart';

typedef Equation = List<dynamic>;

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

  static bool hasOperator(String input) {
    return input.contains(operatorRegex);
  }

  static String removeLastCharFrom(String input) {
    if (input.length == 1)
      return '0';
    else
      return input.substring(0, input.length - 1);
  }

  static String performCalculation(String input) {
    Equation equation = _splitToEquation(input);
    if (!isValidOperation(input)) return input;

    double? result;

    switch (equation[0]) {
      case '÷':
        result = equation[1] / equation[2];
        break;
      case 'x':
        result = equation[1] * equation[2];
        break;
      case '-':
        result = equation[1] - equation[2];
        break;
      case '+':
        result = equation[1] + equation[2];
        break;
    }

    if (result == null) return input;

    if (result - result.floor() == 0)
      return result.toInt().toString();
    else
      return result.toString();
  }

  static bool isValidOperation(String input) {
    if (!hasOperator(input)) return true;

    Equation equation = _splitToEquation(input);
    if (equation[0] == '÷' && equation[2] == 0) return false;
    if (equation[0] == '-' && equation[1] < equation[2]) return false;
    return true;
  }

  static Equation _splitToEquation(String input) {
    int operatorIndex = input.indexOf(operatorRegex);

    String operator = input[operatorIndex];
    double a = double.parse(input.substring(0, operatorIndex));
    double b = double.parse(input.substring(operatorIndex + 1));

    return [operator, a, b];
  }
}
