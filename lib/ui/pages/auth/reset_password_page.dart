import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/ui/getx_state_manager/auth_controller/reset_password_controller.dart';
import 'package:progress_pal/ui/pages/auth/login_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email, otp;
  const ResetPasswordPage({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _confirmPasseordController =
      TextEditingController();
  bool _obscurePassword = true;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Minimum password should be 8 letters with numbers & symbols',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passWordController,
                    obscureText: _obscurePassword,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      prefixIcon: const Icon(
                        Icons.lock_rounded,
                        size: 22,
                      ),
                      suffixIcon: IconButton(
                        color: myColor,
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || value!.length <= 7) {
                        return "Minimum password length should be 8";
                      }
                      final RegExp passwordRegex = RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

                      if (!passwordRegex.hasMatch(value)) {
                        return "Password should contain \nletters, numbers, and symbols.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _confirmPasseordController,
                    obscureText: _obscurePassword,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: const Icon(
                        Icons.lock_rounded,
                        size: 22,
                      ),
                      suffixIcon: IconButton(
                        color: myColor,
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || value!.length <= 7) {
                        return "Enter Confirm password";
                      } else if (value != _passWordController.text) {
                        return "Confirm password doesn't match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GetBuilder<ResetPasswordController>(
                      builder: (resetPasswordController) {
                    return SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible:
                            resetPasswordController.passwordResetInProgress ==
                                false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            resetPasswordController
                                .passwordReset(widget.email, widget.otp,
                                    _passWordController.text)
                                .then((resetPass) {
                              if (resetPass == true) {
                                CustomGetxSnackbar.showSnackbar(
                                    title: "Password reset successful",
                                    message: 'Log in with your new password',
                                    iconData: Icons.error_rounded,
                                    iconColor: Colors.green);
                                Get.offAll(const LoginPage());
                              } else {
                                CustomGetxSnackbar.showSnackbar(
                                    title: "Password reset failed",
                                    message: 'Please try again',
                                    iconData: Icons.error_rounded,
                                    iconColor: Colors.red);
                              }
                            });
                          },
                          child: Text('Confirm Reset Password',
                              style: myButtonTextColor),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
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
                            'Log in',
                            style: myTextButtonStyle,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
