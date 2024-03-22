import 'package:json_annotation/json_annotation.dart';

part 'AccMod.g.dart';

@JsonSerializable()
class AccMod{

  String userId;
  String accountNumber;

  AccMod(this.userId, this.accountNumber);

  factory AccMod.fromJson(Map<String, dynamic> json) => _$AccModFromJson(json);

  Map<String, dynamic> toJson() => _$AccModToJson(this);
}

