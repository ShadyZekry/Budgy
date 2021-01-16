import 'package:Budgy/helpers/database_helper.dart';
import 'package:Budgy/models/Transaction.dart';
import 'package:Budgy/resources/code_strings.dart';

class TransactionService {
  static DatabaseHelper _dbHelper = DatabaseHelper.instance;

  static Future<Transaction> createTransactionWithData(
      Transaction transaction) async {
    _dbHelper.insert(CodeStrings.transactionTableName, transaction.toJson());
    return (await getAllTransaction()).last;
  }

  static Future<Transaction> getTransaction(int transactionId) async {
    List<Map<String, dynamic>> data = await _dbHelper.query(
      tableName: CodeStrings.transactionTableName,
      where: "${CodeStrings.idColumnName} = ?",
      whereArgs: [transactionId.toString()],
    );

    return Transaction.fromJson(data[0]);
  }

  static Future<List<Transaction>> getAllTransaction() async {
    List<Map<String, dynamic>> data = await _dbHelper.query(
      tableName: CodeStrings.transactionTableName,
    );

    return data
        .map<Transaction>((element) => Transaction.fromJson(element))
        .toList();
  }

  static void editTransaction(
      int transactionId, Transaction newTransaction) async {
    _dbHelper.update(
      CodeStrings.transactionTableName,
      CodeStrings.idColumnName,
      transactionId,
      newTransaction.toJson(),
    );
  }

  static void deleteTransaction(int transactionId) async {
    _dbHelper.delete(
      CodeStrings.transactionTableName,
      CodeStrings.idColumnName,
      transactionId,
    );
  }
}
