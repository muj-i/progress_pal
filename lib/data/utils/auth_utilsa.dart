import 'dart:convert';

import 'package:progress_pal/data/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  AuthUtils._();
  static LoginModel userInfo = LoginModel();

  static Future<LoginModel> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String value = sharedPreferences.getString('user-data')!;
    return LoginModel.fromJson(jsonDecode(value));
  }

  static Future<void> saveUserInfo(LoginModel loginModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        'user-data', jsonEncode(loginModel.toJson()));
    userInfo = loginModel;
  }

  static Future<void> updateUserInfo(UserData userData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userInfo.data = userData;
    await sharedPreferences.setString(
        'user-data', jsonEncode(userInfo.toJson()));
  }

  static Future<void> clearUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLogin = sharedPreferences.containsKey('user-data');
    if (isLogin) {
      userInfo = await getUserInfo();
    }
    return isLogin;
  }
}
