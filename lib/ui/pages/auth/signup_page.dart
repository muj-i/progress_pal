import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:progress_pal/ui/getx_state_manager/auth_controller/signup_controller.dart';
import 'package:progress_pal/ui/pages/auth/login_page.dart';
import 'package:progress_pal/ui/pages/bottom_nav_base_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                Text(
                  'Join With Us',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                    prefixIcon: Icon(
                      FontAwesomeIcons.userLarge,
                      size: 19,
                    ),
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter your first name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                    prefixIcon: Icon(
                      FontAwesomeIcons.userLarge,
                      size: 19,
                    ),
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter your last name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _mobileNumberController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Only allow digits
                    LengthLimitingTextInputFormatter(11), // Limit the length
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Mobile Number',
                    prefixIcon: Icon(
                      FontAwesomeIcons.mobile,
                      size: 19,
                    ),
                  ),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || value!.length < 11) {
                      return "Enter your 11 digit mobile number";
                    }
                    final RegExp mobileRegex = RegExp(r'^01[0-9]{9}$');
                    if (!mobileRegex.hasMatch(value)) {
                      return "Enter a valid mobile number";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
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
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: _obscurePassword,
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
                GetBuilder<SignupController>(builder: (signupController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: signupController.signUpInProgress == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          signupController
                              .userSignUp(
                                  _firstNameController.text.trim(),
                                  _lastNameController.text.trim(),
                                  _mobileNumberController.text.trim(),
                                  _emailController.text.trim(),
                                  _passWordController.text,
                                  '')
                              .then((signUp) {
                            if (signUp == true) {
                              CustomGetxSnackbar.showSnackbar(
                                  title: "Sign up successful",
                                  message: 'Navigating to home page',
                                  iconData: Icons.error_rounded,
                                  iconColor: Colors.green);
                              Get.offAll(() => const BottomNavBasePage());
                            } else {
                              CustomGetxSnackbar.showSnackbar(
                                  title: "Sign up failed",
                                  message: 'Please try again',
                                  iconData: Icons.error_rounded,
                                  iconColor: Colors.red);
                            }
                          });
                        },
                        child: Text('Sign Up', style: myButtonTextColor),
                      ),
                    ),
                  );
                }),
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
          "Have account?",
          style: myTextStyle,
        ),
        TextButton(
          onPressed: () {
            Get.offAll(() => const LoginPage());
          },
          child: Text(
            "Log in",
            style: myTextButtonStyle,
          ),
        )
      ],
    );
  }
}
