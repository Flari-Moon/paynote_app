// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['sId'] as String,
    json['accountId'] as String,
    json['accountNumber'] as String,
    json['type'] as String,
    json['currencyCode'] as String,
    json['iV'] as int,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['user_exist'] as bool,
    json['phoneNumber'] as String,
    json['countryCode'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['dateOfBirth'] as String,
    json['picture'] as String,
    json['pinCode'] as String,
    json['country'] as String,
    json['email'] as String,
    json['id'] as String,
    json['createdAt'] as String,
    json['updatedAt'] as String,
    json['deeplink'] as String,
    json['userId'] as String,
    (json['balance'] as num)?.toDouble(),
    (json['accounts'] as List)
        ?.map((e) => e == null
            ? null
            : AccountsModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['transactions'] as List)
        ?.map((e) => e == null
            ? null
            : TransactionMainModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['subscriptions'] as List)
        ?.map((e) => e == null
            ? null
            : SubscriptionModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['currentBalance'] as num,
    json['amountToSpend'] as num,
    json['totalSubscriptionsAmount'] as num,
  )..message = json['message'] as String;
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user': instance.user,
      'user_exist': instance.user_exist,
      'phoneNumber': instance.phoneNumber,
      'countryCode': instance.countryCode,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth,
      'picture': instance.picture,
      'pinCode': instance.pinCode,
      'country': instance.country,
      'email': instance.email,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'deeplink': instance.deeplink,
      'userId': instance.userId,
      'message': instance.message,
      'balance': instance.balance,
      'currentBalance': instance.currentBalance,
      'amountToSpend': instance.amountToSpend,
      'totalSubscriptionsAmount': instance.totalSubscriptionsAmount,
      'accounts': instance.accounts,
      'transactions': instance.transactions,
      'subscriptions': instance.subscriptions,
      'iV':instance.iV,
      'currencyCode':instance.currencyCode,
      'type':instance.type,
      'accountNumber':instance.accountNumber,
      'accountId':instance.accountId,
      'sId':instance.sId
    };
