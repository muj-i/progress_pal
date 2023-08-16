import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class CustomGetxSnackbar {
  static void showSnackbar({
    required String title,
    required String message,
    required IconData iconData,
    required Color iconColor,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      backgroundColor: Colors.white,
      borderRadius: 10,
      animationDuration: const Duration(milliseconds: 400),
      icon: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }
}
