import 'package:get/get.dart';
import 'package:progress_pal/data/model/login_model.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/data/utils/urls.dart';

class LoginController extends GetxController {
  bool _logInProgress = false;
  bool get logInProgress => _logInProgress;
  Future<bool> logIn(String email, password) async {
    _logInProgress = true;
    update();

    Map<String, dynamic> requestBody = {"email": email, "password": password};
    final NetworkResponse responce =
        await NetworkCaller().postRequest(Urls.login, requestBody);
    _logInProgress = false;
    update();

    if (responce.isSuccess) {
      AuthUtils.saveUserInfo(LoginModel.fromJson(responce.body!));
      return true;
    } else {
      return false;
    }
  }
}
