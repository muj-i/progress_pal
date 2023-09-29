import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_backgrounds.dart';

class ImagePickerSheet extends StatelessWidget {
  final VoidCallback onTap1;

  final VoidCallback onTap2;
  const ImagePickerSheet(
      {super.key, required this.onTap1, required this.onTap2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: InsideScreenBackground(
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: myColor
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon:  Icon(
                    Icons.close_rounded,
                    size: 32,
                    color: myColor,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            ),
            ListTile(
              leading:  Icon(
                Icons.photo_library_rounded,
                size: 28,
                color: myColor,
              ),
              title:  Text(
                'Gallery',
                style: TextStyle(color: myColor, fontSize: 20),
              ),
              onTap: onTap1,
            ),
            ListTile(
              leading:  Icon(
                Icons.photo_camera_rounded,
                size: 28,
                color: myColor,
              ),
              title:  Text(
                'Camera',
                style: TextStyle(color: myColor, fontSize: 20),
              ),
              onTap: onTap2,
            ),
          ],
        ),
      ),
    );
  }
}
