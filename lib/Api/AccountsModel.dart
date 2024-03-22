import 'package:json_annotation/json_annotation.dart';

part 'AccountsModel.g.dart';

@JsonSerializable()
class AccountsModel {
  String id;
  String userId;
  String accountId;
  String accountNumber;
  String type;
  double balance;
  String currencyCode;

  AccountsModel({this.id,
    this.userId,
    this.accountId,
    this.accountNumber,
    this.type,
    this.balance,
    this.currencyCode});


  @override
  String toString() {
    return 'AccountsModel{id: $id, userId: $userId, accountId: $accountId, accountNumber: $accountNumber, type: $type, balance: $balance, currencyCode: $currencyCode}';
  }

  factory AccountsModel.fromJson(Map<String, dynamic> json) =>  _$AccountsModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountsModelToJson(this);

}