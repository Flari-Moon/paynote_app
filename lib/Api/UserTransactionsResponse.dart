import 'package:json_annotation/json_annotation.dart';

import 'TransactionSortedDateModel.dart';

part 'UserTransactionsResponse.g.dart';

@JsonSerializable()
class UserTransactionsResponse {
  int status;
  String message;
  TransactionsData data;

  UserTransactionsResponse({this.status, this.message, this.data});

  factory UserTransactionsResponse.fromJson(Map<String, dynamic> json) => _$UserTransactionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserTransactionsResponseToJson(this);
}

@JsonSerializable()
class TransactionsData {
  List<TransactionSortedDateModel> transactions;

  TransactionsData({this.transactions});

  factory TransactionsData.fromJson(Map<String, dynamic> json) => _$TransactionsDataFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionsDataToJson(this);
}