import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/ui/pages/about_page.dart';
import 'package:progress_pal/ui/pages/auth/login_page.dart';
import 'package:progress_pal/ui/pages/update/update_profile_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
      },
      child: AppBar(
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
                  child: ClipOval(
                    child: AuthUtils.userInfo.data?.photo != null
                        ? Image.network(
                            AuthUtils.userInfo.data!.photo!,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                color: myColor,
                              );
                            },
                          )
                        : Icon(
                            Icons.person,
                            color: myColor,
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              '${AuthUtils.userInfo.data?.firstName ?? 'No name found'} ${AuthUtils.userInfo.data?.lastName ?? ''}',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              AuthUtils.userInfo.data?.email ?? 'No email found',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
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
                  Navigator.pop(context);
                },
                onRightButtonPressed: () async {
                  await AuthUtils.clearUserInfo();

                  if (mounted) {
                    Get.off(const LoginPage());
                    //   Navigator.pushAndRemoveUntil(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const LoginPage()),
                    //       (route) => false);
                  }
                },
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
    );
  }
}
