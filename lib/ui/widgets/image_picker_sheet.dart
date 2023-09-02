import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class ImagePickerSheet extends StatelessWidget {
  final VoidCallback onTap1;

  final VoidCallback onTap2;
  const ImagePickerSheet(
      {super.key, required this.onTap1, required this.onTap2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ScreenBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Choose an action',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 32,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library_rounded,
                size: 28,
                color: Colors.white,
              ),
              title: const Text(
                'Gallery',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: onTap1,
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_camera_rounded,
                size: 28,
                color: Colors.white,
              ),
              title: const Text(
                'Camera',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: onTap2,
            ),
          ],
        ),
      ),
    );
  }
}
