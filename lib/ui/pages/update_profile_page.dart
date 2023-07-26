import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                'Update Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Image Placeholder',
                  prefixIcon: Icon(
                    FontAwesomeIcons.image,
                    size: 19,
                  ),
                ),
              ),const SizedBox(
                height: 16,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  prefixIcon: Icon(
                    FontAwesomeIcons.userLarge,
                    size: 19,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  prefixIcon: Icon(
                    FontAwesomeIcons.userLarge,
                    size: 19,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Mobile Number',
                  prefixIcon: Icon(
                    FontAwesomeIcons.mobile,
                    size: 19,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  prefixIcon: Icon(
                    Icons.lock_rounded,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ResetPasswordPage()),
                    //     (route) => false);
                  },
                  child: const Text('Update Information'),
                ),
              ),
              
            ],
          ),
        ),
      )),
    );
  } //sign up option method
}
