import 'package:budgy/utils/transaction_utils.dart';
import 'package:flutter/cupertino.dart';

class KeyboardState {
  TextEditingController _controller;

  String get text => _controller.text;
  set text(String newText) => _controller.text = newText;
  bool get isInputZero =>
      TransactionUtility.getFormatedAmountDouble(_controller) == 0;

  KeyboardState._internal(String text)
      : _controller = TextEditingController(text: text);

  factory KeyboardState(String text) {
    return KeyboardState._internal(text);
  }
}
