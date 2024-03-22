


import 'package:json_annotation/json_annotation.dart';
import 'Data.dart';

part 'BResponse.g.dart';

@JsonSerializable()
class BResponse {
  int status;
  String message;
  Data data;

  BResponse({this.status, this.message, this.data});

  factory BResponse.fromJson(Map<String, dynamic> json) =>  _$BResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BResponseToJson(this);
}

