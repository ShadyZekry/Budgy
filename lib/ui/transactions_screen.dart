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
      floatingActionButton:
          FloatingActionButton(onPressed: _onIncrementTransactions),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _hastransactions
                ? _buildAnimatedList()
                : Text("no transactions"),
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
          child: Container(
            child: Text(
                '${transactions[index].datetime}:    ${transactions[index].amount}${transactions[index].currency}'),
          ),
        );
      },
    );
  }

  void _onIncrementTransactions() {
    Transaction _newTransaction = Transaction.fromJson(
      {
        CodeStrings.datetimeColumnName: DateTime.now().toString(),
        CodeStrings.amountColumnName: 10,
        CodeStrings.currencyColumnName: "EGP",
        CodeStrings.isExpenseColumnName: 1,
        CodeStrings.categoryIdColumnName: 0,
      },
    );

    TransactionService.createTransaction(_newTransaction);
    transactions.add(_newTransaction);

    if (listkey.currentState == null) return;

    listkey.currentState.insertItem(0);
  }

  bool get _hastransactions {
    return transactions?.isNotEmpty ?? false;
  }
}
