import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';

class PinVerifyController extends GetxController {
  bool _otpVerificationInProgress = false;
  bool get otpVerificationInProgress => _otpVerificationInProgress;

  Future<bool> verifyOTP(String email, otp) async {
    _otpVerificationInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.verifyOtpToEmail(email, otp));

    _otpVerificationInProgress = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
