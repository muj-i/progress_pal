import 'package:flutter/material.dart';
import 'package:progress_pal/pages/forgot_password_page.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

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
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150,),
              Text(
                'Get Started With',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  prefixIcon: Icon(Icons.email_rounded),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  prefixIcon: Icon(Icons.lock_rounded),
                  
                ),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
            (route) => false);},
                  child: Text('Login'),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
