import 'package:flutter/material.dart';
import 'package:progress_pal/ui/pages/update_profile_page.dart';

var myTextStyle =
    const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 0.5);

var myButtonTextColor =
    const TextStyle(color: Colors.white);


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
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()));  
       
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
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            'User email',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
