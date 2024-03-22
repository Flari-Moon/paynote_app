import 'package:json_annotation/json_annotation.dart';

part 'SubscriptionModel.g.dart';

@JsonSerializable()
class SubscriptionModel {
  String subscriptionName;
  String iban;
  String defaultAmount;
  int totalCount;
  String totalAmount;

  SubscriptionModel(
    this.subscriptionName,
    this.iban,
    this.defaultAmount,
    this.totalCount,
    this.totalAmount,
  );

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>  _$SubscriptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}
