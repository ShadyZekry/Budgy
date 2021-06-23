import 'package:budgy/helpers/database_helper.dart';
import 'package:budgy/resources/res.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter increments smoke test', () async {
    final DatabaseHelper _dbHelper = DatabaseHelper.instance;

    List<Map<String, dynamic>> data =
        await _dbHelper.query(tableName: CodeStrings.transactionTableName);

    expect(data, isNotNull);
  });
}
