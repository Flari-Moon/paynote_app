import 'package:json_annotation/json_annotation.dart';
import 'package:paynote_app/Api/SubscriptionModel.dart';
import 'package:paynote_app/Api/TransactionMainModel.dart';

import 'User.dart';
import 'AccountsModel.dart';

part 'Data.g.dart';

@JsonSerializable()
class Data {
  User user;
  bool user_exist;
  String phoneNumber;
  String countryCode;
  String firstName;
  String lastName;
  String dateOfBirth;
  String picture;
  String pinCode;
  String country;
  String email;
  String id;
  String createdAt;
  String updatedAt;
  String deeplink;
  String userId;
  String message;
  double balance;
  num currentBalance;
  num amountToSpend;
  num totalSubscriptionsAmount;
  List<AccountsModel> accounts;
  List<TransactionMainModel> transactions;
  List<SubscriptionModel> subscriptions;
  String sId;
  String accountId;
  String accountNumber;
  String type;
  String currencyCode;
  int iV;

  Data(
      this.sId,
    this.accountId,
    this.accountNumber,this.type,this.currencyCode,this.iV,
    this.user,
    this.user_exist,
    this.phoneNumber,
    this.countryCode,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.picture,
    this.pinCode,
    this.country,
    this.email,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deeplink,
    this.userId,
    this.balance,
    this.accounts,
    this.transactions,
    this.subscriptions,
    this.currentBalance,
    this.amountToSpend,
    this.totalSubscriptionsAmount,
  );

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
