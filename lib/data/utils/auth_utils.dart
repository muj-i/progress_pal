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
    final updatedData = {
      if (userData.firstName != null) 'firstName': userData.firstName,
      if (userData.lastName != null) 'lastName': userData.lastName,
      if (userData.mobile != null) 'mobile': userData.mobile,
      if (userData.email != null) 'email': userData.email, // Retain the email
    };
    userInfo.value.data = userData; // Update the user data
    await box.write('user-data', jsonEncode(updatedData));
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
