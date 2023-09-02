import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/ui/getx_state_manager/update_controller/update_pass_controller.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class UpdatePasswordBottomSheet extends StatefulWidget {
  const UpdatePasswordBottomSheet({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordBottomSheet> createState() =>
      _UpdatePasswordBottomSheetState();
}

class _UpdatePasswordBottomSheetState extends State<UpdatePasswordBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _confirmPasseordController =
      TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Change Password',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 32,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      )
                    ],
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
                  GetBuilder<UpdatePassController>(
                      builder: (updatePassController) {
                    return SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible:
                            updatePassController.passwordUpdateInProgress ==
                                false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            updatePassController
                                .passwordUpdate(_passWordController.text)
                                .then((updatePass) {
                              if (updatePass == true) {
                                CustomGetxSnackbar.showSnackbar(
                                    title: 'Password update successful',
                                    message: "Keep your password safe",
                                    iconData: Icons.error_rounded,
                                    iconColor: Colors.green);
                                Navigator.pop(context);
                              } else {
                                CustomGetxSnackbar.showSnackbar(
                                    title: 'Password update failed',
                                    message: 'Please try again',
                                    iconData: Icons.error_rounded,
                                    iconColor: Colors.red);
                              }
                            });
                          },
                          child: Text('Confirm Change Password',
                              style: myButtonTextColor),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
