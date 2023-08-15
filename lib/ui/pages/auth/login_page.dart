import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/ui/getx_state_manager/auth_controller/login_controller.dart';
import 'package:progress_pal/ui/pages/auth/email_verify_page.dart';
import 'package:progress_pal/ui/pages/auth/signup_page.dart';
import 'package:progress_pal/ui/pages/bottom_nav_base_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
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
                TextFormField(
                  controller: _passWordController,
                  obscureText: _obscurePassword,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                    if ((value?.isEmpty ?? true) || value!.length <= 5) {
                      return "Enter your password";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                GetBuilder<LoginController>(builder: (loginController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: loginController.logInProgress == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          loginController
                              .logIn(_emailController.text.trim(),
                                  _passWordController.text)
                              .then((logIn) {
                            if (logIn == true) {
                              CustomGetxSnackbar.showSnackbar(
                                  title: 'Log in successful',
                                  message: "Welcome to Progress Pal",
                                  iconData: Icons.error_rounded,
                                  iconColor: Colors.green);
                              Get.offAll(const BottomNavBasePage());
                            } else {
                              CustomGetxSnackbar.showSnackbar(
                                  title: "Log in failed",
                                  message:
                                      'Please try again with registered email & password',
                                  iconData: Icons.error_rounded,
                                  iconColor: Colors.red);
                            }
                          });
                        },
                        child: Text('Log In', style: myButtonTextColor),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const EmailVerifyPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: myTextStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
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
          "Don't have account?",
          style: myTextStyle,
        ),
        TextButton(
          onPressed: () {
            Get.offAll(const SignupPage());
          },
          child: Text(
            "Sign Up",
            style: myTextButtonStyle,
          ),
        )
      ],
    );
  }
}
