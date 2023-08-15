import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:progress_pal/ui/getx_state_manager/pin_verify_controller.dart';
import 'package:progress_pal/ui/pages/auth/login_page.dart';
import 'package:progress_pal/ui/pages/auth/reset_password_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class PinVerifyPage extends StatefulWidget {
  final String email;
  const PinVerifyPage({super.key, required this.email});

  @override
  State<PinVerifyPage> createState() => _PinVerifyPageState();
}

class _PinVerifyPageState extends State<PinVerifyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              Text(
                'PIN Verification',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'A 6 digit verification pin has been sent to your email address',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: _formKey,
                child: PinCodeTextField(
                  controller: _otpController,
                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: Colors.white,
                    activeFillColor: Colors.white,
                    inactiveColor: Colors.red[200],
                    inactiveFillColor: Colors.white,
                    selectedColor: myColor,
                    selectedFillColor: Colors.white,
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter the OTP sent to your email";
                    }
                    return null;
                  },
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return false;
                  },
                  appContext: context,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GetBuilder<PinVerifyController>(builder: (pinVerifyController) {
                return SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible:
                        pinVerifyController.otpVerificationInProgress == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        pinVerifyController
                            .verifyOTP(widget.email, _otpController.text)
                            .then((otpVerifiy) {
                          if (otpVerifiy == true) {
                            Get.to(ResetPasswordPage(
                                email: widget.email, otp: _otpController.text));
                          } else {
                            CustomGetxSnackbar.showSnackbar(
                                title: "OTP verification failed",
                                message:
                                    'Please try again with the OTP sent to your email',
                                iconData: Icons.error_rounded,
                                iconColor: Colors.red);
                          }
                        });
                      },
                      child: Text('Verify', style: myButtonTextColor),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 16,
              ),
              signUpOption()
            ],
          ),
        ),
      )),
    );
  } //sign up option method

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No need to reset password?",
          style: myTextStyle,
        ),
        TextButton(
          onPressed: () {
            Get.offAll(const LoginPage());
          },
          child: Text(
            "Log In",
            style: myTextButtonStyle,
          ),
        )
      ],
    );
  }
}
