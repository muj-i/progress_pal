import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/ui/getx_state_manager/auth_controller/email_verify_controller.dart';
import 'package:progress_pal/ui/pages/auth/login_page.dart';
import 'package:progress_pal/ui/pages/auth/pin_verify_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_backgrounds.dart';

class EmailVerifyPage extends StatefulWidget {
  const EmailVerifyPage({super.key});

  @override
  State<EmailVerifyPage> createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                Text(
                  'Your Email Here',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'A 6 digit verification pin will send to your email address',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      size: 22,
                    ),
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter your email address";
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value!)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                GetBuilder<EmailVerifyController>(
                    builder: (emailVerifyController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible:
                          emailVerifyController.emailVerificationInProgress ==
                              false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          emailVerifyController
                              .sendOtpToEmail(
                            _emailController.text.trim(),
                          )
                              .then((emailVerify) {
                            if (emailVerify == true) {
                              Get.offAll(() => PinVerifyPage(
                                    email: _emailController.text.trim(),
                                  ));
                            } else {
                              CustomGetxSnackbar.showSnackbar(
                                  title: "Email verify failed",
                                  message:
                                      'Please try again with a registered email',
                                  iconData: Icons.error_rounded,
                                  iconColor: Colors.red);
                            }
                          });
                        },
                        child: Text('Send OTP', style: myButtonTextColor),
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
            Get.offAll(() => const LoginPage());
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
