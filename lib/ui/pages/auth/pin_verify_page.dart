import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:progress_pal/ui/pages/auth/login_page.dart';
import 'package:progress_pal/ui/pages/auth/reset_password_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class PinVerifyPage extends StatefulWidget {
  const PinVerifyPage({super.key});

  @override
  State<PinVerifyPage> createState() => _PinVerifyPageState();
}

class _PinVerifyPageState extends State<PinVerifyPage> {
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
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              PinCodeTextField(
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
                  selectedColor: Colors.green,
                  selectedFillColor: Colors.white,
                ),
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
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage()),
                        (route) => false);
                  },
                  child: const Text('Verify'),
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
            style: myTextStyle,
          ),
        )
      ],
    );
  }
}
