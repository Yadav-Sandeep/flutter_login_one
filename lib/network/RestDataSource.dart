import 'dart:async';
import 'package:flutter_login_one/view/CommonData.dart';

import '../model/LoginResponse.dart';
import 'NetworkUtil.dart';


class RestDataSource {
  NetworkUtil _netUtil = new NetworkUtil();

  Future<LoginResponse> postLogin(String body) {
    return _netUtil
        .post(CommonData().url + '/jarvisgwy/broker/agentlogin',
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