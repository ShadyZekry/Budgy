import 'package:budgy/utils/transaction_repo.dart';
import 'package:flutter/cupertino.dart';

class KeyboardState {
  TextEditingController _controller;
  bool isExpense;

  String get text => _controller.text;
  set text(String newText) => _controller.text = newText;
  double? get textAsNum =>
      TransactionRepository.getFormatedAmountDouble(_controller);

  bool get isInputZero => textAsNum == 0;
  bool get hasCalculation => TransactionRepository.hasOperator(text);
  bool get lastDigitIsCalc =>
      text[text.length - 1].contains(RegExp(r'\÷|x|\-|\+'));
  bool get shouldRemoveFromInput =>
      text.isNotEmpty &&
      (double.tryParse(text) == null || double.parse(text) > 0);

  KeyboardState._internal(String text, bool isExpense)
      : _controller = TextEditingController(text: text),
        isExpense = isExpense;

  factory KeyboardState({required String text, required bool isExpense}) =>
      KeyboardState._internal(text, isExpense);

  KeyboardState copyWith({String? text, bool? isExpense}) {
    return KeyboardState(
      text: text ?? this.text,
      isExpense: isExpense ?? this.isExpense,
    );
  }
}
