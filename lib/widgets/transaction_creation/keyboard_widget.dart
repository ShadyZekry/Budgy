import 'package:budgy/models/Transaction.dart';
import 'package:budgy/resources/res.dart';
import 'package:budgy/services/transaction.dart';
import 'package:budgy/utils/transaction_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  final TextEditingController textController;
  final Function refreshResult;
  final bool isExpense;
  KeyboardWidget({this.textController, this.refreshResult, this.isExpense});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 5,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildKeyboardButtonWidget(title: '÷'),
          _buildKeyboardButtonWidget(title: '7', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '8', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '9', function: _addStringToResult),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.backspace, color: AppColors.white),
              function: _removeLastValueFromResult),
          _buildKeyboardButtonWidget(title: 'x'),
          _buildKeyboardButtonWidget(title: '4', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '5', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '6', function: _addStringToResult),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.calendar_today, color: AppColors.white)),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.remove, color: AppColors.white)),
          _buildKeyboardButtonWidget(title: '1', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '2', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '3', function: _addStringToResult),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.check, color: AppColors.white),
              function: _createTransaction),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.add, color: AppColors.white)),
          _buildKeyboardButtonWidget(title: '0', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '.'),
        ],
      ),
    );
  }

  Widget _buildKeyboardButtonWidget(
      {String title, Icon icon, Function function}) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: FlatButton(
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

  void _addStringToResult(String value) {
    textController.text += value;
  }

  void _removeLastValueFromResult(_) {
    if (textController.text.isEmpty || double.parse(textController.text) <= 0)
      return;

    textController.text =
        textController.text.substring(0, textController.text.length - 1);
  }

  void _createTransaction(_) async {
    Transaction _newTransaction =
        await TransactionService.createTransactionWithData(
      Transaction.empty()
        ..datetime = DateTime.now()
        ..categoryId = 1
        ..isExpense = isExpense
        ..amount = TransactionUtility.getFormatedAmountDouble(textController)
        ..currency = "EGP",
    );

    ExtendedNavigator.root.pop(_newTransaction);
  }
}
