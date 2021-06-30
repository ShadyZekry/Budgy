import 'dart:html';

import 'package:budgy/bloc/transaction/states.dart';
import 'package:budgy/utils/transaction_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransitionEvent, TransactionState> {
  TransactionBloc(TransactionState initialState) : super(initialState);

  @override
  Stream<TransactionState> mapEventToState(TransitionEvent event) async* {
    state
  }

  void performCalculation(TextEditingController controller) {
    int operatorIndex =
        controller.text.indexOf(RegExp(TransactionUtility.operatorRegex));
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

  double? _performDivision(
      TextEditingController controller, double a, double b) {
    if (b == 0) return null;
    return a / b;
  }

  double _performMultiplication(
          TextEditingController controller, double a, double b) =>
      a * b;
  double? _performSubtraction(
      TextEditingController controller, double a, double b) {
    if (a < b) return null;
    return a - b;
  }

  double _performAddition(
          TextEditingController controller, double a, double b) =>
      a + b;
}
