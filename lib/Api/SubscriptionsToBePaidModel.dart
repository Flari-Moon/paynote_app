import 'package:json_annotation/json_annotation.dart';

part 'SubscriptionsToBePaidModel.g.dart';

@JsonSerializable()
class SubscriptionsToBePaidModel {
  String subscription_name;
  String iban;
  double totalAmount;

  SubscriptionsToBePaidModel(
    this.subscription_name,
    this.iban,
    this.totalAmount,
  );

  factory SubscriptionsToBePaidModel.fromJson(Map<String, dynamic> json) => _$SubscriptionsToBePaidModelFromJson(json);
}
