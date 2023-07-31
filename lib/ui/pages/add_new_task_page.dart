import 'package:flutter/material.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class AddNewTaskPage extends StatelessWidget {
  const AddNewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TwoAppBar(
        tittle: 'Add New Task',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Tittle',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                maxLines: 10,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Description',
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
                  child: Text('Save Task', style: myButtonTextColor),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      )),
    );
  }
  //sign up option method
}
