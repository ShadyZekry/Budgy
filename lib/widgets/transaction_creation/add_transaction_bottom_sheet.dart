import 'package:budgy/resources/colors.dart';
import 'package:budgy/widgets/transaction_creation/keyboard_widget.dart';
import 'package:flutter/material.dart';

class AddTransactionBottomSheet extends StatefulWidget {
  final bool isExpense;
  AddTransactionBottomSheet(this.isExpense);

  @override
  _AddTransactionBottomSheetState createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends State<AddTransactionBottomSheet> {
  TextEditingController _textController = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        children: [
          _buildResultWidget(),
          KeyboardWidget(
            textController: _textController,
            refreshResult: setState,
            isExpense: widget.isExpense,
          ),
        ],
      ),
    );
  }

  Widget _buildResultWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Text(
        _textController.text,
        style: TextStyle(
          fontSize: 30,
          color: widget.isExpense
              ? AppColors.expenseIndicatorColor
              : AppColors.incomeIndicatorColor,
        ),
      ),
    );
  }
}
