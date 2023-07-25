import 'package:flutter/material.dart';
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
                'Get Started With',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  prefixIcon: Icon(Icons.email_rounded),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  prefixIcon: Icon(Icons.lock_rounded),
                ),
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
                            builder: (context) => const BottomNavBasePage()),
                        (route) => false);
                  },
                  child: const Text('Log In'),
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
            style: myTextStyle,
          ),
        )
      ],
    );
  }
}
