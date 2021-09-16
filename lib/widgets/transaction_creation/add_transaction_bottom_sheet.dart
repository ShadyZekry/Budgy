import 'package:budgy/bloc/keyboard/bloc.dart';
import 'package:budgy/bloc/keyboard/states.dart';
import 'package:budgy/resources/colors.dart';
import 'package:budgy/widgets/transaction_creation/keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionBottomSheet extends StatefulWidget {
  @override
  _AddTransactionBottomSheetState createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends State<AddTransactionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        children: [
          _buildResultWidget(),
          KeyboardWidget(),
        ],
      ),
    );
  }

  Widget _buildResultWidget() {
    return BlocBuilder<KeyboardBloc, KeyboardState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            state.text,
            style: TextStyle(
              fontSize: 30,
              color: state.isExpense
                  ? AppColors.expenseIndicatorColor
                  : AppColors.incomeIndicatorColor,
            ),
          ),
        );
      },
    );
  }
}
