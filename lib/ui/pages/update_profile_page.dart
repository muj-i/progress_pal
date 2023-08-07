import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_pal/data/model/login_model.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/data/utils/urls.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passeordController = TextEditingController();
  UserData userSharedperfData = AuthUtils.userInfo.data!;
  bool _profileUpdateInProgress = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = userSharedperfData?.firstName ?? '';
    _lastNameController.text = userSharedperfData?.lastName ?? '';
    _mobileNumberController.text = userSharedperfData?.mobile ?? '';
    _emailController.text = userSharedperfData?.email ?? '';
  }

  Future<void> profileUpdate() async {
    _profileUpdateInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final Map<String, dynamic> requestBody = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileNumberController.text.trim(),
      "photo": ""
    };

    if (_passeordController.text.isNotEmpty) {
      requestBody["password"] = _passeordController.text;
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);
    _profileUpdateInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      userSharedperfData.firstName = _firstNameController.text.trim();
      userSharedperfData.lastName = _lastNameController.text.trim();
      userSharedperfData.mobile = _mobileNumberController.text.trim();
      AuthUtils.updateUserInfo(userSharedperfData);
      _passeordController.clear();
      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Profile updated successfully');
      }
      Navigator.pop(context);
    } else {
      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Profile updated failed');
      }
    }
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
                      return "Enter your valid mobile number";
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
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        size: 22,
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            CustomSnackbar.show(
                                context: context,
                                message: "Email can't be changed");
                          },
                          child: Icon(
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
                TextFormField(
                  controller: _passeordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        size: 22,
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            CustomSnackbar.show(
                                context: context,
                                message:
                                    "If you don't want to change your password,\nKeep the password field empty.");
                          },
                          child: Icon(
                            FontAwesomeIcons.circleExclamation,
                            size: 20,
                          ))),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || value!.length <= 5) {
                      return "Enter password more than 6 letter";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  child: _profileUpdateInProgress
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            profileUpdate();
                          },
                          child: Text('Update Information',
                              style: myButtonTextColor),
                        ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
