import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';

class UpdatePassController extends GetxController {
  bool _passwordUpdateInProgress = false;
  bool get passwordUpdateInProgress => _passwordUpdateInProgress;

  Future<bool> passwordUpdate(String password) async {
    _passwordUpdateInProgress = true;
    update();
    Map<String, dynamic> requestBody = {"password": password};

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);

    _passwordUpdateInProgress = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
