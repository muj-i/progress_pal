import 'package:flutter/material.dart';


var myTextStyle = const TextStyle(
    color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5);

var myTextButtonStyle = const TextStyle(
    color: Color.fromARGB(255, 10, 29, 66),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5);

var myButtonTextColor = const TextStyle(color: Colors.white);

var myColor = const Color.fromARGB(255, 10, 29, 66);

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String tittle;
  const BasicAppBar({
    super.key,
    required this.tittle,
    TextStyle? style,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 65,
      title: Text(tittle),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}


