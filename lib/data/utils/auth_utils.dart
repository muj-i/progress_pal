import 'dart:convert';

import 'package:progress_pal/data/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  AuthUtils._();
  static LoginModel userInfo = LoginModel();

  static Future<LoginModel> getUserInfo() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String value = _sharedPreferences.getString('user-data')!;
    return LoginModel.fromJson(jsonDecode(value));
  }

  static Future<void> saveUserInfo(LoginModel loginModel) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString(
        'user-data', jsonEncode(loginModel.toJson()));
    userInfo = loginModel;
  }

  static Future<void> updateUserInfo(UserData userData) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    userInfo.data = userData;
    await _sharedPreferences.setString(
        'user-data', jsonEncode(userInfo.toJson()));
    
  }

  static Future<void> clearUserInfo() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.clear();
  }

  static Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    bool isLogin = _sharedPreferences.containsKey('user-data');
    if (isLogin) {
      userInfo = await getUserInfo();
    }
    return isLogin;
  }
}
