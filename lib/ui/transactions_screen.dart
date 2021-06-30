import 'package:flutter/material.dart';
import 'package:budgy/models/transaction.dart';
import 'package:budgy/resources/res.dart';
import 'package:budgy/services/transaction.dart';
import 'package:budgy/widgets/transaction_box.dart';
import 'package:budgy/widgets/transaction_creation/add_transaction_bottom_sheet.dart';

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
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => _onAddTransactions(true),
            child: const Icon(Icons.insert_drive_file),
          ),
          FloatingActionButton(
            onPressed: () => _onAddTransactions(false),
            child: const Icon(Icons.monetization_on),
          ),
          FloatingActionButton(
            onPressed: _onRemoveTransactions,
            child: const Icon(Icons.remove),
          ),
        ],
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
    Transaction? _newTransaction = await showModalBottomSheet<Transaction>(
      context: context,
      builder: (_) => AddTransactionBottomSheet(isExpense: isExpense),
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
