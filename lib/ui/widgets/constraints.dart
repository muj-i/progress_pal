import 'package:flutter/material.dart';

var myTextStyle =
    const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 0.5);

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  //final String appBarTitle;

  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('This is a SnackBar!'),
            duration: const Duration(
                seconds: 2), // Duration for which the SnackBar is visible
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
        },
        child: const Column(
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
                  backgroundImage: NetworkImage(
                      'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png'),
                ),
              ],
            ),
          ],
        ),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            'User name',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          Text(
            'User email',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
