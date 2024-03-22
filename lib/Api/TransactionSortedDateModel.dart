import 'package:json_annotation/json_annotation.dart';

part 'TransactionSortedDateModel.g.dart';

@JsonSerializable()
class TransactionSortedDateModel {
  String accountId;
  String amount;
  String categoryId;
  String categoryName;
  String categoryType;
  int date;
  String description;
  String formattedDescription;
  String id;
  int inserted;
  int lastModified;
  String merchantId;
  String notes;
  double originalAmount;
  String originalDate;
  String originalDescription;
  Payload payload;
  bool pending;
  String timestamp;
  String type;
  String userId;
  bool upcoming;
  bool userModifiedAmount;
  bool userModifiedCategory;
  bool userModifiedDate;
  bool userModifiedDescription;
  bool userModifiedLocation;
  CurrencyDenominatedAmount currencyDenominatedAmount;
  CurrencyDenominatedAmount currencyDenominatedOriginalAmount;
  List<String> parts;
  InternalPayload internalPayload;
  InternalPayload partnerPayload;
  double dispensableAmount;
  bool userModified;

  TransactionSortedDateModel(
      {this.accountId,
      this.amount,
      this.categoryId,
      this.categoryName,
      this.categoryType,
      this.date,
      this.description,
      this.formattedDescription,
      this.id,
      this.inserted,
      this.lastModified,
      this.merchantId,
      this.notes,
      this.originalAmount,
      this.originalDate,
      this.originalDescription,
      this.payload,
      this.pending,
      this.timestamp,
      this.type,
      this.userId,
      this.upcoming,
      this.userModifiedAmount,
      this.userModifiedCategory,
      this.userModifiedDate,
      this.userModifiedDescription,
      this.userModifiedLocation,
      this.currencyDenominatedAmount,
      this.currencyDenominatedOriginalAmount,
      this.parts,
      this.internalPayload,
      this.partnerPayload,
      this.dispensableAmount,
      this.userModified});

  factory TransactionSortedDateModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionSortedDateModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionSortedDateModelToJson(this);
}

@JsonSerializable()
class Payload {
  String DETAILS;
  String TRANSFER_ACCOUNT_EXTERNAL;
  String MESSAGE;
  String TRANSFER_ACCOUNT_NAME_EXTERNAL;

  Payload(
      {this.DETAILS,
      this.TRANSFER_ACCOUNT_EXTERNAL,
      this.MESSAGE,
      this.TRANSFER_ACCOUNT_NAME_EXTERNAL});

  factory Payload.fromJson(Map<String, dynamic> json) =>
      _$PayloadFromJson(json);
  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}

@JsonSerializable()
class CurrencyDenominatedAmount {
  int unscaledValue;
  int scale;
  String currencyCode;

  CurrencyDenominatedAmount(
      {this.unscaledValue, this.scale, this.currencyCode});

  factory CurrencyDenominatedAmount.fromJson(Map<String, dynamic> json) =>
      _$CurrencyDenominatedAmountFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyDenominatedAmountToJson(this);
}

@JsonSerializable()
class InternalPayload {
  InternalPayload();

  factory InternalPayload.fromJson(Map<String, dynamic> json) =>
      _$InternalPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$InternalPayloadToJson(this);
}
