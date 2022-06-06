import 'package:flutter_login_one/LoginResponse.dart';
import 'RestDataSource.dart';

abstract class LoginContract {
  void onLoginSuccess(LoginResponse response);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginContract _view;
  RestDataSource api = new RestDataSource();
  LoginScreenPresenter(this._view);

  postLogin(String body) {
    api.postLogin(body).then((LoginResponse res) {
      _view.onLoginSuccess(res);

    }).catchError((Object error) => _view.onLoginError(error.toString()));
  }
}