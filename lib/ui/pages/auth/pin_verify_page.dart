import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';
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
  bool _otpVerificationInProgress = false;

  Future<void> _verifyOTP() async {
    _otpVerificationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.verifyOtpToEmail(widget.email, _otpController.text));

    _otpVerificationInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordPage(
              email: widget.email,
              otp: _otpController.text,
            ),
          ),
        );
      }
    } else {
      CustomSnackbar.show(context: context, message: "Wrong OTP entered.");
    }
  }

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
                  //errorAnimationController: errorController,
                  //controller: textEditingController,
                  onCompleted: (v) {
                    // print("Completed");
                  },
                  onChanged: (value) {
                    // print(value);
                    // setState(() {
                    //  // currentText = value;
                    // });
                  },
                  beforeTextPaste: (text) {
                    // print("Allowing to paste $text");
                    // //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    // //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _otpVerificationInProgress == false,
                  replacement: Center(child: const CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _verifyOTP();
                    },
                    child: Text('Verify', style: myButtonTextColor),
                  ),
                ),
              ),
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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false);
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
