import 'package:Budgy/resources/colors.dart';
import 'package:Budgy/utils/transaction_utils.dart';
import 'package:Budgy/widgets/transaction_creation/keyboard_widget.dart';
import 'package:flutter/material.dart';

class AddTransactionBottomSheet extends StatefulWidget {
  @override
  _AddTransactionBottomSheetState createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends State<AddTransactionBottomSheet> {
  TextEditingController _textController = TextEditingController();

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
              textController: _textController, refreshResult: setState),
        ],
      ),
    );
  }

  Widget _buildResultWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Text(
        _textController.text.isEmpty
            ? '0'
            : TransactionUtility.getFormatedAmountString(_textController),
        style: TextStyle(color: AppColors.expenseIndicatorColor, fontSize: 30),
      ),
    );
  }
}
