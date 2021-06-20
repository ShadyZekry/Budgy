import 'package:budgy/models/Transaction.dart';
import 'package:budgy/resources/code_strings.dart';
import 'package:budgy/services/transaction.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budgy"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Your money'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              _incrementCounter();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () async {
              print(await TransactionService.getTransaction(1));
            },
            tooltip: 'show',
            child: Icon(Icons.query_builder),
          ),
          FloatingActionButton(
            onPressed: () async {
              print(await TransactionService.getAllTransaction());
            },
            tooltip: 'show all',
            child: Icon(Icons.get_app),
          ),
        ],
      ),
    );
  }
}
