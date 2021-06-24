import 'package:budgy/MyApp.dart';
import 'package:budgy/models/Transaction.dart';
import 'package:budgy/resources/res.dart';
import 'package:budgy/services/transaction.dart';
import 'package:budgy/utils/transaction_utils.dart';
import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  final TextEditingController textController;
  final Function refreshResult;
  final bool isExpense;
  KeyboardWidget(
      {required this.textController,
      required this.refreshResult,
      required this.isExpense});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 5,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildCalculationButton('÷'),
          _buildNumberButton(7),
          _buildNumberButton(8),
          _buildNumberButton(9),
          _buildBackspaceButton(),
          _buildCalculationButton('x'),
          _buildNumberButton(4),
          _buildNumberButton(5),
          _buildNumberButton(6),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.calendar_today, color: AppColors.white)),
          _buildCalculationButton('-'),
          _buildNumberButton(1),
          _buildNumberButton(2),
          _buildNumberButton(3),
          _buildSubmitButton(),
          _buildCalculationButton('+'),
          _buildNumberButton(0),
          _buildKeyboardButtonWidget(title: '.'),
        ],
      ),
    );
  }

  Widget _buildKeyboardButtonWidget(
      {String? title, Icon? icon, Function? function}) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () {
          if (function != null) function(title);
          refreshResult(() {});
        },
        child: Center(
          child: title == null
              ? icon
              : Text(title,
                  style: TextStyle(fontSize: 35, color: AppColors.white)),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () {
          _removeLastValueFromResult();
          refreshResult(() {});
        },
        onLongPress: () {
          textController.text = '0';
          refreshResult(() {});
        },
        child: Center(child: Icon(Icons.backspace, color: AppColors.white)),
      ),
    );
  }

  Widget _buildCalculationButton(String calculation) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () {
          if (textController.text[textController.text.length - 1]
              .contains(RegExp(r'\÷|x|\-|\+')))
            textController.text = textController.text
                .replaceFirst(RegExp(r'\÷|x|\-|\+'), calculation);
          else if (TransactionUtility.hasCalculation(textController)) {
            TransactionUtility.performCalculation(textController);
            textController.text += calculation;
          } else
            textController.text += calculation;

          refreshResult(() {});
        },
        child: Center(
          child: Text(calculation,
              style: TextStyle(fontSize: 35, color: AppColors.white)),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () {
          if (TransactionUtility.hasCalculation(textController))
            TransactionUtility.performCalculation(textController);
          else {
            if (_isInputZero) return;
            _createTransaction();
          }

          refreshResult(() {});
        },
        child: Center(
          child: TransactionUtility.hasCalculation(textController)
              ? Text('=',
                  style: TextStyle(fontSize: 35, color: AppColors.white))
              : Icon(Icons.check, color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () {
          if (_isInputZero)
            textController.text = number.toString();
          else
            textController.text += number.toString();
          refreshResult(() {});
        },
        child: Center(
          child: Text(number.toString(),
              style: TextStyle(fontSize: 35, color: AppColors.white)),
        ),
      ),
    );
  }

  void _removeLastValueFromResult() {
    if (!_shouldRemoveFromInput) return;

    if (textController.text.length == 1)
      textController.text = '0';
    else
      textController.text =
          textController.text.substring(0, textController.text.length - 1);
  }

  void _createTransaction() async {
    Transaction _newTransaction =
        await TransactionService.createTransactionWithData(Transaction(
      datetime: DateTime.now(),
      currency: "EGP",
      categoryId: 1,
      isExpense: isExpense,
      amount: TransactionUtility.getFormatedAmountDouble(textController)!,
    ));
    appRouter.root.pop(_newTransaction);
  }

  bool get _shouldRemoveFromInput {
    return textController.text.isNotEmpty &&
        (double.tryParse(textController.text) == null ||
            double.parse(textController.text) > 0);
  }

  bool get _isInputZero =>
      TransactionUtility.getFormatedAmountDouble(textController) == 0;
}
