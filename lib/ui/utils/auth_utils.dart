import 'dart:convert';

import 'package:progress_pal/data/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthUtils {
  AuthUtils._();

  static Future<LoginModel> getUserInfo() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String value = _sharedPreferences.getString('user-data')!;
    return LoginModel.fromJson(jsonDecode(value));
  }

  static Future<void> saveUserInfo(LoginModel model) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString('user-data', model.toJson().toString());
  }

  static Future<void> clearUserInfo() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.clear();
  }

  static Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.containsKey('user-data');
  }
}
