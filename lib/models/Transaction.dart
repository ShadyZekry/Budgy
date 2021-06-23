import 'package:json_annotation/json_annotation.dart';
part 'Transaction.g.dart';

@JsonSerializable()
class Transaction {
  int? id;
  DateTime datetime;
  double amount;
  String currency;
  @JsonKey(
    name: "is_expense",
    toJson: _isExpenseToJson,
    fromJson: _isExpenseFromJson,
  )
  bool isExpense;
  @JsonKey(name: "category_id")
  int categoryId;

  Transaction({
    this.id,
    required this.datetime,
    required this.amount,
    required this.currency,
    required this.isExpense,
    required this.categoryId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  static bool _isExpenseFromJson(int value) => value == 1 ? true : false;
  static int _isExpenseToJson(bool value) => value ? 1 : 0;
}
