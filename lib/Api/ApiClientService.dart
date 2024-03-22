import 'package:dio/dio.dart' hide Headers;
import 'package:paynote_app/Api/BResponse.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/adapter.dart';
import 'dart:io';

import 'Language.dart';
import 'User.dart';
import 'AccMod.dart';

part 'ApiClientService.g.dart';

@RestApi(baseUrl: "https://paynote.de/api/")
abstract class ApiClientService {
  factory ApiClientService(Dio dio, {String baseUrl}) {
    dio.options =
        BaseOptions(receiveTimeout: 30 * 1000, connectTimeout: 30 * 1000);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return _ApiClientService(dio, baseUrl: baseUrl);
  }

  @POST("users")
  Future<BResponse> signUpUser(@Body() User data);

  @POST("tink/addBank")
  Future<BResponse> addBank(@Body() Map<String, dynamic> body);

  @PUT("users")
  Future<BResponse> updateUser(@Body() User data);

  @GET("users")
  Future<BResponse> getUser(
      @Query('phoneNumber') String phoneNumber, @Query('filter') String filter);

  @GET("tink/accountLists")
  Future<BResponse> getAccountList(@Query('userId') String userId);

  @DELETE("tink/userAccount")
  Future<BResponse> deleteUserAccount(@Body() Map<String, dynamic> body);

  @GET("tink/accountBalance")
  Future<BResponse> getAccountBalance(
      @Query('accountId') String accountId, @Query('userId') String userId);

  @GET("tink/userTransactions")
  Future<BResponse> getUserTransactions(
      @Query('userId') String userId,
      @Query('skip') int skip,
      @Query('limit') int limit,
      @Query('filter') String filter,
      @Query('accountId') String accountId);

  @GET("tink/userSubscriptions")
  Future<BResponse> userSubscriptions(
    @Query('userId') String userId,
    @Query('size') int size,
    @Query('pageNo') int pageNo,
  );

  @POST("tink/accountBuffer")
  Future<BResponse> userBuffer(@Body() AccMod accMod);

  // @PUT("language")
  // Future<BResponse> updateLanguage(@Body() Language language);
}
