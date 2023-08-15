import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_pal/data/model/login_model.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/ui/getx_state_manager/update_profile_controller.dart';
import 'package:progress_pal/ui/pages/update/update_pass.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _imageFile;
  UserData userSharedperfData = AuthUtils.userInfo.data!;

  @override
  void initState() {
    super.initState();
    
    _firstNameController.text = userSharedperfData.firstName ?? '';
    _lastNameController.text = userSharedperfData.lastName ?? '';
    _mobileNumberController.text = userSharedperfData.mobile ?? '';
    _emailController.text = userSharedperfData.email ?? '';
  }


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        tittle: 'Update Profile',
        style: Theme.of(context).textTheme.titleLarge,
      ),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      color: Colors.white,
                      child: _imageFile == null
                          ? Icon(
                              Icons.person,
                              color: myColor,
                              size: 60,
                            )
                          : Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
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
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
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
                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: 'Email Address',
                      prefixIcon: const Icon(
                        Icons.email_rounded,
                        size: 22,
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            CustomSnackbar.show(
                                context: context,
                                message: "Email can't be changed");
                          },
                          child: const Icon(
                            FontAwesomeIcons.circleExclamation,
                            size: 20,
                          ))),
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
                GetBuilder<UpdateProfileController>(
                    builder: (updateProfileController) {
                  return SizedBox(
                    width: double.infinity,
                    child: updateProfileController.profileUpdateInProgress
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              updateProfileController
                                  .profileUpdate(
                                      _firstNameController.text.trim(),
                                      _lastNameController.text.trim(),
                                      _mobileNumberController.text.trim(),
                                      '')
                                  .then((updateProfile) {
                                if (updateProfile == true) {
                                  CustomGetxSnackbar.showSnackbar(
                                      title: 'Profile updated successful',
                                      message: "Navigate to home page",
                                      iconData: Icons.error_rounded,
                                      iconColor: Colors.green);
                                  if (mounted) {
                                    Navigator.pop(context);
                                  } else {
                                    CustomGetxSnackbar.showSnackbar(
                                        title: "Profile updated failed",
                                        message: 'Please try again',
                                        iconData: Icons.error_rounded,
                                        iconColor: Colors.red);
                                  }
                                }
                              });
                            },
                            child: Text('Update Information',
                                style: myButtonTextColor),
                          ),
                  );
                }),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showUpdatePasswordBottomSheet();
                    },
                    child: Text('Change Password', style: myButtonTextColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void showUpdatePasswordBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const UpdatePasswordBottomSheet(),
          );
        });
  }
}
