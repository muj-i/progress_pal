import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_pal/data/model/login_model.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/data/utils/base64image.dart';
import 'package:progress_pal/ui/getx_state_manager/update_controller/update_profile_controller.dart';
import 'package:progress_pal/ui/pages/update/update_pass.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/image_picker_sheet.dart';
import 'package:progress_pal/ui/widgets/sceen_backgrounds.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());

  UserData userSharedperfData = AuthUtils.userInfo.value.data!;
  @override
  void initState() {
    super.initState();
    _firstNameController.text = userSharedperfData.firstName ?? '';
    _lastNameController.text = userSharedperfData.lastName ?? '';
    _mobileNumberController.text = userSharedperfData.mobile ?? '';
    _emailController.text = userSharedperfData.email ?? '';
  }

  File? _imageFile;
  String? base64String;
  Future<void> _pickImage(ImageSource imageSource) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: imageSource, imageQuality: 30);
      if (pickedImage == null) return;

      _imageFile = File(pickedImage.path);

      if (_imageFile != null) {
        base64String = await Base64Image.base64EncodedString(_imageFile);
      }

      setState(() {});
    } on PlatformException catch (e) {
      if (mounted) {
        CustomSnackbar.show(context: context, message: 'Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        tittle: 'Update Profile',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      body: InsideScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => _imageSelectBottomSheet(context),
                  child: CircleAvatar(
                    maxRadius: 50,
                    foregroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : Base64Image.getBase64Image(
                            userSharedperfData.photo!),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                style: TextStyle(color: myColor),
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
                style: TextStyle(color: myColor),
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
                style: TextStyle(color: myColor),
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
                style: TextStyle(color: myColor),
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
                            final newProfileImage =
                                base64String ?? userSharedperfData.photo;
                            updateProfileController
                                .profileUpdate(
                              _firstNameController.text.trim(),
                              _lastNameController.text.trim(),
                              _mobileNumberController.text.trim(),
                              userSharedperfData.email,
                              newProfileImage ?? "",
                            )
                                .then((updateProfile) {
                              if (updateProfile == true) {
                                userSharedperfData.firstName =
                                    _firstNameController.text.trim();
                                userSharedperfData.lastName =
                                    _lastNameController.text.trim();
                                userSharedperfData.mobile =
                                    _mobileNumberController.text.trim();
                                userSharedperfData.email =
                                    userSharedperfData.email;
                                userSharedperfData.photo = newProfileImage;
          
                                AuthUtils.updateUserInfo(userSharedperfData);
          
                                setState(() {});
                                CustomSnackbar.show(
                                    context: context,
                                    message: 'Profile updated successful');
                                Get.back();
          
                                if (mounted) {
                                  Get.back();
                                } else {
                                  CustomSnackbar.show(
                                    context: context,
                                    message: "Profile updated failed",
                                  );
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
        ),
      ),
    );
  }

  void showUpdatePasswordBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const UpdatePasswordBottomSheet(),
        );
      },
    );
  }

  void _imageSelectBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerSheet(
          onTap1: () {
            _pickImage(ImageSource.gallery);
            Get.back();
          },
          onTap2: () {
            _pickImage(ImageSource.camera);
            Get.back();
          },
        );
      },
    );
  }
}
