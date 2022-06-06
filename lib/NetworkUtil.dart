import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'LoginResponse.dart';

class NetworkUtil {
  static NetworkUtil _instance = NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;
  final JsonDecoder _decoder = JsonDecoder();

  Future<dynamic> get(String url, {required Map<String, String> headers}) {
    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url,
      {required Map<String, String> headers, body, encoding}) async {
    return http
        .post(Uri.parse(url), body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      print("Response- " + res);
      final int statusCode = response.statusCode;

      LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(res));

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      } else if( loginResponse.respcode != "00"){
        throw Exception(loginResponse.response);
      } else{
        return _decoder.convert(res);
      }
    });
  }
}