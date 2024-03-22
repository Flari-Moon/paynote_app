
import 'package:dio/dio.dart';
import 'package:paynote_app/Api/ApiClientService.dart';
import 'package:paynote_app/Api/BResponse.dart';
import 'package:paynote_app/utils/Response.dart';

class ApiClient {
  final client = ApiClientService(Dio(BaseOptions(contentType: "application/json")));
  BResponse baseResponse= new BResponse();
}