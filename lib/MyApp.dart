import 'package:Budgy/ui/home_screen.dart';
import 'package:Budgy/ui/transactions_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TransactionsScreen(),
    );
  }
}
