import 'package:budgy/utils/transaction_utils.dart';
import 'package:flutter/cupertino.dart';

class KeyboardState {
  TextEditingController _controller;
  bool isExpense;

  String get text => _controller.text;
  set text(String newText) => _controller.text = newText;
  double? get textAsNum =>
      TransactionRepository.getFormatedAmountDouble(_controller);

  bool get isInputZero =>
      TransactionRepository.getFormatedAmountDouble(_controller) == 0;
  bool get hasCalculation => TransactionRepository.hasCalculation(_controller);
  bool get lastDigitIsCalc =>
      text[text.length - 1].contains(RegExp(r'\÷|x|\-|\+'));

  KeyboardState._internal(String text, bool isExpense)
      : _controller = TextEditingController(text: text),
        isExpense = true;

  factory KeyboardState({required String text, required bool isExpense}) =>
      KeyboardState._internal(text, isExpense);

  KeyboardState copyWith({String? text, bool? isExpense}) {
    return KeyboardState(
      text: text ?? this.text,
      isExpense: isExpense ?? this.isExpense,
    );
  }
}
