import 'package:get/get.dart';
import 'package:progress_pal/data/model/login_model.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/data/utils/urls.dart';

class UpdateProfileController extends GetxController {
  bool _profileUpdateInProgress = false;
  bool get profileUpdateInProgress => _profileUpdateInProgress;
  UserData? userSharedperfData = AuthUtils.userInfo.value.data;

  Future<bool> profileUpdate(
    String firstName,
    lastName,
    mobile,
    email,
    photo,
  ) async {
    _profileUpdateInProgress = true;
    update();
    final Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "email": email,
      "photo": photo
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);
    _profileUpdateInProgress = false;
    update();
    if (response.isSuccess) {
      userSharedperfData?.firstName = firstName;
      userSharedperfData?.lastName = lastName;
      userSharedperfData?.mobile = mobile;
      userSharedperfData?.email = email;
      if (userSharedperfData != null) {
        AuthUtils.updateUserInfo(userSharedperfData!);
        update();
      }
      return true;
    } else {
      return false;
    }
  }
}
