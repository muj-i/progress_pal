import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progress_pal/data/model/login_model.dart';

class AuthUtils {
  AuthUtils._();
  static Rx<LoginModel> userInfo = Rx(LoginModel());

  static Future<LoginModel> getUserInfo() async {
    final box = GetStorage();
    final value = box.read('user-data');
    userInfo(LoginModel.fromJson(jsonDecode(value)));
    return userInfo.value;
  }

  static Future<void> saveUserInfo(LoginModel loginModel) async {
    final box = GetStorage();
    await box.write('user-data', jsonEncode(loginModel.toJson()));
    userInfo(loginModel);
  }

  static Future<void> updateUserInfo(UserData userData) async {
    final box = GetStorage();
    userInfo.update((val) {
      val!.data = userData;
    });
    await box.write('user-data', jsonEncode(userInfo.value.toJson()));
  }

  static Future<void> clearUserInfo() async {
    final box = GetStorage();
    await box.remove('user-data');
    userInfo(LoginModel());
  }

  static RxBool isLoggedIn = RxBool(false);

  static Future<bool> checkIfUserLoggedIn() async {
    final box = GetStorage();
    isLoggedIn.value = box.hasData('user-data');
    if (isLoggedIn.value) {
      await getUserInfo(); // Update userInfo
    }
    return isLoggedIn.value;
  }
}
