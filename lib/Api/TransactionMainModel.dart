import 'package:json_annotation/json_annotation.dart';
import 'package:paynote_app/Api/TransactionSortedDateModel.dart';
part 'TransactionMainModel.g.dart';

@JsonSerializable()
class TransactionMainModel {
  String date;
  TransactionSortedDateModel transaction;

  TransactionMainModel(this.date, this.transaction);

  factory TransactionMainModel.fromJson(Map<String, dynamic> json) => _$TransactionMainModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionMainModelToJson(this);
}