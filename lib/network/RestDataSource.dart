import 'dart:async';
import '../model/LoginResponse.dart';
import 'NetworkUtil.dart';


class RestDataSource {
  NetworkUtil _netUtil = new NetworkUtil();

  var baseURL = "https://Jiffyuat.nsdlbank.co.in";

  Future<LoginResponse> postLogin(String body) {
    return _netUtil
        .post(baseURL + '/jarvisgwy/broker/agentlogin',
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body: body)
        .then((dynamic res) {
      return LoginResponse.fromJson(res);
    });
  }
}