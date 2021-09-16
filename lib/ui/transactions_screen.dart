import 'package:budgy/bloc/keyboard/bloc.dart';
import 'package:budgy/bloc/keyboard/events.dart';
import 'package:budgy/ui/home_fab/expanding_fab.dart';
import 'package:flutter/material.dart';
import 'package:budgy/models/transaction.dart';
import 'package:budgy/resources/res.dart';
import 'package:budgy/services/transaction.dart';
import 'package:budgy/widgets/transaction_box.dart';
import 'package:budgy/widgets/transaction_creation/add_transaction_bottom_sheet.dart';
import 'package:provider/src/provider.dart';

import 'home_fab/action_button.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final GlobalKey<AnimatedListState> listkey = GlobalKey<AnimatedListState>();

  List<Transaction> transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    TransactionService.getAllTransaction().then((result) {
      transactions = result;
      _isLoading = false;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: ExpandingFAB(
          distance: 100,
          children: [
            ActionButton(
              onPressed: () => _onAddTransactions(true),
              icon: const Icon(Icons.minimize),
              color: AppColors.expenseIndicatorColor,
            ),
            ActionButton(
              onPressed: () => _onAddTransactions(false),
              icon: const Icon(Icons.add),
              color: AppColors.incomeIndicatorColor,
            ),
            ActionButton(
              onPressed: () => _onRemoveTransactions(),
              icon: const Icon(Icons.delete),
              color: AppColors.white,
            ),
          ],
        ),
      ),
      body:
          //TODO:: remove this center widget
          Center(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _hastransactions
                ? _buildAnimatedList()
                : const Text(
                    "no transactions",
                    style: TextStyle(color: AppColors.textGrey),
                  ),
      ),
    );
  }

  Widget _buildAnimatedList() {
    return AnimatedList(
      key: listkey,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      initialItemCount: transactions.length,
      itemBuilder: (_, int index, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: TransactionBox(transactions[index]),
          ),
        );
      },
    );
  }

  void _onAddTransactions(bool isExpense) async {
    context
        .read<KeyboardBloc>()
        .add(AddTransactionPressed(isExpense: isExpense));

    Transaction? _newTransaction = await showModalBottomSheet<Transaction>(
      context: context,
      builder: (_) => AddTransactionBottomSheet(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );

    if (_newTransaction == null) return;
    transactions.add(_newTransaction);

    setState(() {});
    if (listkey.currentState == null) return;

    listkey.currentState?.insertItem(transactions.length - 1);
  }

  void _onRemoveTransactions() {
    if (listkey.currentState == null) return;

    Transaction _transactionToDelete = transactions[0];

    listkey.currentState?.removeItem(
      0,
      (_, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: TransactionBox(_transactionToDelete),
          ),
        );
      },
    );

    TransactionService.deleteTransaction(_transactionToDelete.id!);
    transactions.removeAt(0);
    setState(() {});
  }

  bool get _hastransactions {
    return transactions.isNotEmpty;
  }
}
