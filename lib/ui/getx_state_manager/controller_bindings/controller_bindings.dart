import 'package:get/get.dart';
import 'package:progress_pal/ui/getx_state_manager/add_new_task_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/auth_controller/email_verify_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/auth_controller/login_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/auth_controller/pin_verify_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/auth_controller/reset_password_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/auth_controller/signup_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/get_cancelled_task_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/get_completed_task_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/get_inprogress_task_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/get_new_task_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/summary_count_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/update_controller/update_pass_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/update_controller/update_profile_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(SignupController());
    Get.put(EmailVerifyController());
    Get.put(PinVerifyController());
    Get.put(ResetPasswordController());
    Get.put(UpdateProfileController());
    Get.put(UpdatePassController());
    Get.put(SummaryCountController());
    //Get.put(DeleteTaskController());
    Get.put(GetNewTaskController());
    Get.put(GetInprogressTaskController());
    Get.put(GetCompletedTaskController());
    Get.put(GetCancelledTaskController());
    Get.put(AddNewTaskController());
  }
}
