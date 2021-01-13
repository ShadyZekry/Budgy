import 'package:json_annotation/json_annotation.dart';
part 'Transaction.g.dart';

@JsonSerializable()
class Transaction {
  DateTime datetime;
  int amount;
  String currency;
  @JsonKey(name: "is_expense")
  bool isExpense;
  @JsonKey(name: "category_id")
  int categoryId;

  Transaction(
    this.datetime,
    this.amount,
    this.currency,
    this.isExpense,
    this.categoryId,
  );

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
