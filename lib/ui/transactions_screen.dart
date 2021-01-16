import 'package:Budgy/models/Transaction.dart';
import 'package:Budgy/resources/res.dart';
import 'package:Budgy/services/transaction.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: AppColors.accentBlack,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _onAddTransactions,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _onRemoveTransactions,
            child: Icon(Icons.remove),
          ),
        ],
      ),
      body:
          //TODO:: remove thi center widget
          Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _hastransactions
                ? _buildAnimatedList()
                : Text(
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
      initialItemCount: transactions?.length,
      itemBuilder: (_, int index, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: _buildTransactionBox(transactions[index]),
          ),
        );
      },
    );
  }

  void _onAddTransactions() async {
    Transaction _newTransaction = Transaction.empty()
      ..datetime = DateTime.now()
      ..amount = 10
      ..currency = "EGP"
      ..isExpense = true
      ..categoryId = 0;

    _newTransaction =
        await TransactionService.createTransactionWithData(_newTransaction);
    transactions.add(_newTransaction);

    setState(() {});
    if (listkey.currentState == null) return;

    listkey.currentState.insertItem(transactions.length - 1);
  }

  void _onRemoveTransactions() {
    if (listkey.currentState == null) return;

    Transaction _transactionToDelete = transactions[0];

    listkey.currentState.removeItem(
      0,
      (_, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: _buildTransactionBox(_transactionToDelete),
          ),
        );
      },
    );

    TransactionService.deleteTransaction(_transactionToDelete.id);
    transactions.removeAt(0);
    setState(() {});
  }

  Widget _buildTransactionBox(Transaction _transaction) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppColors.boxColor, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'id:   ${_transaction.id}',
            style: TextStyle(color: AppColors.textGrey),
          ),
          Text(
            'datetime:  ${_transaction.datetime}',
            style: TextStyle(color: AppColors.textGrey),
          ),
          // Text(
          //   'amount:  ${_transaction.amount}${_transaction.currency}',
          //   style: TextStyle(color: AppColors.textGrey),
          // ),
        ],
      ),
    );
  }

  bool get _hastransactions {
    return transactions?.isNotEmpty ?? false;
  }
}
