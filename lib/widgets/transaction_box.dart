import 'package:budgy/models/transaction.dart';
import 'package:budgy/resources/res.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionBox extends StatelessWidget {
  final Transaction _transaction;
  TransactionBox(this._transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppColors.boxColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 10),
            width: 5,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: _transaction.isExpense
                  ? AppColors.expenseIndicatorColor
                  : AppColors.incomeIndicatorColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'id:   ${_transaction.id}',
                style: const TextStyle(color: AppColors.textGrey),
              ),
              Text(
                'amount:   ${_transaction.amount}',
                style: const TextStyle(color: AppColors.textGrey),
              ),
              Text(
                DateFormat('dd MMMM y on HH:mm').format(_transaction.datetime),
                style: const TextStyle(color: AppColors.textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
