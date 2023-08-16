import 'package:flutter/material.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';

class DialogBox {
  static Future<void> show({
    required BuildContext context,
    required String contentMessage,
    required String leftButtonText,
    required String rightButtonText,
    required VoidCallback onLeftButtonPressed,
    required VoidCallback onRightButtonPressed,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            contentMessage,
            style: myTextButtonStyle,
          ),
          actions: [
            TextButton(
              onPressed: onLeftButtonPressed,
              child: Text(
                leftButtonText,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: onRightButtonPressed,
              child: Text(
                rightButtonText,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomDialogBox {
  static Future<void> show({
    required BuildContext context,
    required String contentMessage,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            contentMessage,
            style: myTextButtonStyle,
          ),
          actions: [
            TextButton(
              onPressed: onButtonPressed,
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
