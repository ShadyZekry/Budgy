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
          _buildKeyboardButtonWidget(title: '÷'),
          _buildNumberButton(7),
          _buildNumberButton(8),
          _buildNumberButton(9),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.backspace, color: AppColors.white),
              function: _removeLastValueFromResult),
          _buildKeyboardButtonWidget(title: 'x'),
          _buildNumberButton(4),
          _buildNumberButton(5),
          _buildNumberButton(6),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.calendar_today, color: AppColors.white)),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.remove, color: AppColors.white)),
          _buildNumberButton(1),
          _buildNumberButton(2),
          _buildNumberButton(3),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.check, color: AppColors.white),
              function: _createTransaction),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.add, color: AppColors.white)),
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

  Widget _buildNumberButton(int number) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () {
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

  void _removeLastValueFromResult(_) {
    if (textController.text.isEmpty || double.parse(textController.text) <= 0)
      return;

    textController.text =
        textController.text.substring(0, textController.text.length - 1);
  }

  void _createTransaction(_) async {
    Transaction _newTransaction =
        await TransactionService.createTransactionWithData(Transaction(
      datetime: DateTime.now(),
      currency: "EGP",
      categoryId: 1,
      isExpense: isExpense,
      amount: TransactionUtility.getFormatedAmountDouble(textController),
    ));
    appRouter.root.pop(_newTransaction);
  }
}
