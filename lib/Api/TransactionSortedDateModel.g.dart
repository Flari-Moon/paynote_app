// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransactionSortedDateModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSortedDateModel _$TransactionSortedDateModelFromJson(
    Map<String, dynamic> json) {
  return TransactionSortedDateModel(
    accountId: json['accountId'] as String,
    amount: json['amount'] as String,
    categoryId: json['categoryId'] as String,
    categoryName: json['categoryName'] as String,
    categoryType: json['categoryType'] as String,
    date: json['date'] as int,
    description: json['description'] as String,
    formattedDescription: json['formattedDescription'] as String,
    id: json['id'] as String,
    inserted: json['inserted'] as int,
    lastModified: json['lastModified'] as int,
    merchantId: json['merchantId'] as String,
    notes: json['notes'] as String,
    originalAmount: (json['originalAmount'] as num)?.toDouble(),
    originalDate: json['originalDate'] as String,
    originalDescription: json['originalDescription'] as String,
    payload: json['payload'] == null
        ? null
        : Payload.fromJson(json['payload'] as Map<String, dynamic>),
    pending: json['pending'] as bool,
    timestamp: json['timestamp'] as String,
    type: json['type'] as String,
    userId: json['userId'] as String,
    upcoming: json['upcoming'] as bool,
    userModifiedAmount: json['userModifiedAmount'] as bool,
    userModifiedCategory: json['userModifiedCategory'] as bool,
    userModifiedDate: json['userModifiedDate'] as bool,
    userModifiedDescription: json['userModifiedDescription'] as bool,
    userModifiedLocation: json['userModifiedLocation'] as bool,
    currencyDenominatedAmount: json['currencyDenominatedAmount'] == null
        ? null
        : CurrencyDenominatedAmount.fromJson(
            json['currencyDenominatedAmount'] as Map<String, dynamic>),
    currencyDenominatedOriginalAmount:
        json['currencyDenominatedOriginalAmount'] == null
            ? null
            : CurrencyDenominatedAmount.fromJson(
                json['currencyDenominatedOriginalAmount']
                    as Map<String, dynamic>),
    parts: (json['parts'] as List)?.map((e) => e as String)?.toList(),
    internalPayload: json['internalPayload'] == null
        ? null
        : InternalPayload.fromJson(
            json['internalPayload'] as Map<String, dynamic>),
    partnerPayload: json['partnerPayload'] == null
        ? null
        : InternalPayload.fromJson(
            json['partnerPayload'] as Map<String, dynamic>),
    dispensableAmount: (json['dispensableAmount'] as num)?.toDouble(),
    userModified: json['userModified'] as bool,
  );
}

Map<String, dynamic> _$TransactionSortedDateModelToJson(
        TransactionSortedDateModel instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'amount': instance.amount,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'categoryType': instance.categoryType,
      'date': instance.date,
      'description': instance.description,
      'formattedDescription': instance.formattedDescription,
      'id': instance.id,
      'inserted': instance.inserted,
      'lastModified': instance.lastModified,
      'merchantId': instance.merchantId,
      'notes': instance.notes,
      'originalAmount': instance.originalAmount,
      'originalDate': instance.originalDate,
      'originalDescription': instance.originalDescription,
      'payload': instance.payload,
      'pending': instance.pending,
      'timestamp': instance.timestamp,
      'type': instance.type,
      'userId': instance.userId,
      'upcoming': instance.upcoming,
      'userModifiedAmount': instance.userModifiedAmount,
      'userModifiedCategory': instance.userModifiedCategory,
      'userModifiedDate': instance.userModifiedDate,
      'userModifiedDescription': instance.userModifiedDescription,
      'userModifiedLocation': instance.userModifiedLocation,
      'currencyDenominatedAmount': instance.currencyDenominatedAmount,
      'currencyDenominatedOriginalAmount':
          instance.currencyDenominatedOriginalAmount,
      'parts': instance.parts,
      'internalPayload': instance.internalPayload,
      'partnerPayload': instance.partnerPayload,
      'dispensableAmount': instance.dispensableAmount,
      'userModified': instance.userModified,
    };

Payload _$PayloadFromJson(Map<String, dynamic> json) {
  return Payload(
    DETAILS: json['DETAILS'] as String,
    TRANSFER_ACCOUNT_EXTERNAL: json['TRANSFER_ACCOUNT_EXTERNAL'] as String,
    MESSAGE: json['MESSAGE'] as String,
    TRANSFER_ACCOUNT_NAME_EXTERNAL:
        json['TRANSFER_ACCOUNT_NAME_EXTERNAL'] as String,
  );
}

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
      'DETAILS': instance.DETAILS,
      'TRANSFER_ACCOUNT_EXTERNAL': instance.TRANSFER_ACCOUNT_EXTERNAL,
      'MESSAGE': instance.MESSAGE,
      'TRANSFER_ACCOUNT_NAME_EXTERNAL': instance.TRANSFER_ACCOUNT_NAME_EXTERNAL,
    };

CurrencyDenominatedAmount _$CurrencyDenominatedAmountFromJson(
    Map<String, dynamic> json) {
  return CurrencyDenominatedAmount(
    unscaledValue: json['unscaledValue'] as int,
    scale: json['scale'] as int,
    currencyCode: json['currencyCode'] as String,
  );
}

Map<String, dynamic> _$CurrencyDenominatedAmountToJson(
        CurrencyDenominatedAmount instance) =>
    <String, dynamic>{
      'unscaledValue': instance.unscaledValue,
      'scale': instance.scale,
      'currencyCode': instance.currencyCode,
    };

InternalPayload _$InternalPayloadFromJson(Map<String, dynamic> json) {
  return InternalPayload();
}

Map<String, dynamic> _$InternalPayloadToJson(InternalPayload instance) =>
    <String, dynamic>{};
