import 'package:get/get.dart';
import 'package:progress_pal/data/model/login_model.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/data/utils/urls.dart';

class SignupController extends GetxController {
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;

  Future<bool> userSignUp(
      String firstName, lastName, mobile, email, password, photo) async {
    _signUpInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "email": email,
      "password": password,
      "photo": photo
    };

    final NetworkResponse responce =
        await NetworkCaller().postRequest(Urls.registration, requestBody);
    _signUpInProgress = false;
    update();
    if (responce.isSuccess) {
      Map<String, dynamic> requestBody = {"email": email, "password": password};
      final NetworkResponse responce =
          await NetworkCaller().postRequest(Urls.login, requestBody);
      if (responce.isSuccess) {
        AuthUtils.saveUserInfo(LoginModel.fromJson(responce.body!));
        update();
      }
      return true;
    } else {
      return false;
    }
  }
}
