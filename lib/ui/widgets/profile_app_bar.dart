import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/data/utils/base64image.dart';
import 'package:progress_pal/ui/pages/about_page.dart';
import 'package:progress_pal/ui/pages/auth/login_page.dart';
import 'package:progress_pal/ui/pages/update/update_profile_page.dart';
import 'package:progress_pal/ui/widgets/dialog_box.dart';

class ProfileAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(65);
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  String? getUserFullName() {
    final data = AuthUtils.userInfo.value.data;
    if (data != null) {
      final firstName = data.firstName ?? 'No name found';
      final lastName = data.lastName ?? '';
      return '$firstName $lastName';
    }
    return 'No name found';
  }

  String? getUserEmail() {
    final data = AuthUtils.userInfo.value.data;
    return data?.email ?? 'No email found';
  }

  String? getUserPhoto() {
    final data = AuthUtils.userInfo.value.data;
    return data?.photo;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 00,
      leading: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.white,
                child: GestureDetector(
                    onTap: () {
                      Get.to(() => const UpdateProfilePage());
                    },
                    child: CircleAvatar(
                      radius: 25,
                      foregroundImage: Base64Image.getBase64Image(
                        getUserPhoto() ?? '',
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
      title: GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              getUserFullName() ?? '',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              getUserEmail() ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            Get.to(
              const AboutPage(),
            );
          },
          icon: const Icon(Icons.error_outline_rounded),
        ),
        IconButton(
          onPressed: () {
            DialogBox.show(
              context: context,
              contentMessage: 'Do you want to log out?',
              leftButtonText: 'Cancel',
              rightButtonText: 'Log out',
              onLeftButtonPressed: () {
                Get.back();
              },
              onRightButtonPressed: () async {
                await AuthUtils.clearUserInfo();

                if (mounted) {
                  Get.offAll(() => const LoginPage());
                }
              },
            );
          },
          icon: const Icon(Icons.logout_rounded),
        ),
      ],
    );
  }
}
