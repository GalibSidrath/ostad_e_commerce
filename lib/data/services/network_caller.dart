import 'dart:convert';

import 'package:e_commerce/data/models/network_response.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger logger;

  NetworkCaller({required this.logger});
  Future<NetworkResponse> getRequest({required String url}) async {
    Uri uri = Uri.parse(url);
    _requestLog(url, {}, {}, '');
    final Response response = await get(uri, headers: {
      'token': '',
    });

    try {
      if (response.statusCode == 200) {
        _responseLog(
            url, response.statusCode, response.body, response.headers, true);
        final decodeBody = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodeBody);
      } else {
        _responseLog(
            url, response.statusCode, response.body, response.headers, false);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      _responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    Uri uri = Uri.parse(url);
    _requestLog(url, {}, body ?? {}, '');
    final Response response = await post(uri,
        body: jsonEncode(body),
        headers: {'token': '', 'content-type': 'application/json'});

    try {
      if (response.statusCode == 200) {
        _responseLog(
            url, response.statusCode, response.body, response.headers, true);
        final decodedBody = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodedBody);
      } else {
        _responseLog(
            url, response.statusCode, response.body, response.headers, false);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      _responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  void _requestLog(String url, Map<String, dynamic> params,
      Map<String, dynamic> body, String token) {
    logger.i('''
    Url: $url
    Params: $params
    Body: $body,
    Token: $token
    ''');
  }

  void _responseLog(String url, int statusCode, dynamic responseBody,
      Map<String, dynamic> headers, bool isSuccess,
      [dynamic error]) {
    String message = '''
    Url: $url
    Status Code: $statusCode
    Headers: $headers,
    Response Body: $responseBody,
    Error: $error,
    ''';
    if (isSuccess) {
      logger.i(message);
    } else {
      logger.e(message);
    }
  }
}