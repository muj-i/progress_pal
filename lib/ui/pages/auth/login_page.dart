import 'package:flutter/material.dart';
import 'package:progress_pal/data/model/login_model.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/data/utils/urls.dart';
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
  final TextEditingController _passeordController = TextEditingController();

  bool _logInProgress = false;

 

  Future<void> logIn() async {
    _logInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "password": _passeordController.text
    };
    final NetworkResponse responce =
        await NetworkCaller().postRequest(Urls.login, requestBody);
    _logInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (responce.isSuccess) {
      LoginModel model = LoginModel.fromJson(responce.body!);
      AuthUtils.saveUserInfo(model);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBasePage()),
            (route) => false);
      }
      setState(() {
        
      });
    } else {
      if (mounted) {

        CustomSnackbar.show(
            context: context, message: 'Incorrect email address or password');
      }
    }
  }

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
                      return "Enter your valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _passeordController,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      size: 22,
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
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _logInProgress == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        logIn();
                      },
                      child: Text('Log In', style: myButtonTextColor),
                    ),
                  ),
                ),
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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
                (route) => false);
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
