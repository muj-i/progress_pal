import 'package:flutter/material.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/ui/pages/auth/login_page.dart';
import 'package:progress_pal/ui/pages/update_profile_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
  });

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
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
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
            SizedBox(
              height: 8,
            ),
            Text(
              (AuthUtils.userInfo.data?.firstName ?? 'No name found') +
                  ' ' +
                  (AuthUtils.userInfo.data?.lastName ?? ''),
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              AuthUtils.userInfo.data?.email ?? 'No email found',
              style: TextStyle(
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                          'Wanna log out?',
                          style: myTextButtonStyle,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              )),
                          TextButton(
                              onPressed: () async {
                                await AuthUtils.clearUserInfo();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                    (route) => false);
                              },
                              child: Text(
                                'Log out',
                                style: TextStyle(color: Colors.redAccent),
                              )),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
