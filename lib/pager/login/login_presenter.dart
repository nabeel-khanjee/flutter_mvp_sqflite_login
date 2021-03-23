import 'package:flutter_sqflite_mvp_architechture/data/rest_data.dart';
import 'package:flutter_sqflite_mvp_architechture/models/user.dart';

abstract class LoginPageContract {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginPagePresernter {
  LoginPageContract _view;
  RestData api = new RestData();
  LoginPagePresernter(this._view);
  doLogin(String username, String password) {
    api
        .login(username, password)
        .then((user) => _view.onLoginSuccess(user))
        .catchError((onError) => _view.onLoginError(onError.toString()));
  }
}
