// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiClientService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClientService implements ApiClientService {
  _ApiClientService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://paynote.de/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<BResponse> signUpUser(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('users',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BResponse> addBank(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('tink/addBank',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BResponse> updateUser(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('users',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BResponse> getUser(phoneNumber, filter) async {
    ArgumentError.checkNotNull(phoneNumber, 'phoneNumber');
    ArgumentError.checkNotNull(filter, 'filter');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'phoneNumber': phoneNumber,
      r'filter': filter
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('users',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BResponse> getAccountList(userId) async {
    ArgumentError.checkNotNull(userId, 'userId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': userId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'tink/accountLists',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BResponse> deleteUserAccount(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('tink/userAccount',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BResponse> getAccountBalance(accountId, userId) async {
    ArgumentError.checkNotNull(accountId, 'accountId');
    ArgumentError.checkNotNull(userId, 'userId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'accountId': accountId,
      r'userId': userId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'tink/accountBalance',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BResponse> getUserTransactions(
      userId, skip, limit, filter, accountId) async {
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(skip, 'skip');
    ArgumentError.checkNotNull(limit, 'limit');
    ArgumentError.checkNotNull(filter, 'filter');
   // ArgumentError.checkNotNull(accountId, 'accountId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'userId': userId,
      r'skip': skip,
      r'limit': limit,
      r'filter': filter,
      r'accountId': accountId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'tink/userTransactions',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BResponse> userSubscriptions(userId, size, pageNo) async {
    ArgumentError.checkNotNull(userId, 'userId');
    ArgumentError.checkNotNull(size, 'size');
    ArgumentError.checkNotNull(pageNo, 'pageNo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'userId': userId,
      r'size': size,
      r'pageNo': pageNo
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'tink/userSubscriptions',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BResponse> userBuffer(accMod) async {
    ArgumentError.checkNotNull(accMod, 'accMod');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(accMod?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'tink/accountBuffer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BResponse.fromJson(_result.data);
    return value;
  }
}
