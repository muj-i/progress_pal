import 'package:flutter/material.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';


class AddNewTaskPage extends StatelessWidget {
  const AddNewTaskPage({super.key});

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
                'Add New Task',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Tittle',
                  prefixIcon: Icon(
                    Icons.text_fields_rounded,
                    
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                 maxLines: 10,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(
                    Icons.description_rounded
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
