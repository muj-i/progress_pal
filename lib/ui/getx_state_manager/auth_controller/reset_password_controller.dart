import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';

class ResetPasswordController extends GetxController {
  bool _passwordResetInProgress = false;
  bool get passwordResetInProgress => _passwordResetInProgress;

  Future<bool> passwordReset(String email, otp, password) async {
    _passwordResetInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.resetPassword, requestBody);

    _passwordResetInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
