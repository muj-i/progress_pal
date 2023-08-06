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

  bool _updateProfileInProgress = false;

  String? _previousFirstName;
  String? _previousLastName;
  String? _previousMobileNumber;
  String? _previousEmail;

  @override
  void initState() {
    super.initState();
    _fetchPreviousData();
  }

  Future<void> _fetchPreviousData() async {
    LoginModel? user = await AuthUtils.getUserInfo();
    if (user.data != null) {
      _previousFirstName = user.data!.firstName;
      _previousLastName = user.data!.lastName;
      _previousMobileNumber = user.data!.mobile;
      _previousEmail = user.data!.email;

      _firstNameController.text = _previousFirstName ?? '';
      _lastNameController.text = _previousLastName ?? '';
      _mobileNumberController.text = _previousMobileNumber ?? '';
      _emailController.text = _previousEmail ?? '';
    }
  }

  Future<void> _onUpdatePressed() async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _mobileNumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passeordController.text.isEmpty) {
      CustomSnackbar.show(
          context: context, message: 'Please fill all the fields');
      return;
    }
    setState(() {
      _updateProfileInProgress = true;
    });
    await userUpdateProfile();

    setState(() {
      _updateProfileInProgress = false;
    });
  }

  Future<void> userUpdateProfile() async {
    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestBody = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileNumberController.text.trim(),
      "email": _emailController.text.trim(),
      "password": _passeordController.text,
      "photo": ""
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);

    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      //SharedPreferences prefs = await SharedPreferences.getInstance();

      LoginModel updatedModel = LoginModel.fromJson(response.body!);
      updatedModel.token = AuthUtils.userInfo.token;

      AuthUtils.saveUserInfo(updatedModel);
      AuthUtils.userInfo = updatedModel;
      setState(() {
        _previousFirstName = updatedModel.data?.firstName;
        _previousLastName = updatedModel.data?.lastName;
        _previousMobileNumber = updatedModel.data?.mobile;
        _previousEmail = updatedModel.data?.email;
      });

      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Profile update successful');
      }
    } else {
      if (mounted) {
        CustomSnackbar.show(context: context, message: 'Profile update failed');
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
                  keyboardType: TextInputType.text,
                  obscureText: true,
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
                  child: ElevatedButton(
                    onPressed:
                        _updateProfileInProgress ? null : _onUpdatePressed,
                    child: _updateProfileInProgress
                        ? CircularProgressIndicator() // Show the circular progress indicator
                        : Text('Update Information', style: myButtonTextColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  } //sign up option method
}
