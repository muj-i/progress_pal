import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_pal/ui/utils/assets_utils.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SvgPicture.asset(
          AssetUtils.backgroundSVG,
          fit: BoxFit.cover,
        ),
      ),
      SafeArea(child: child),
    ]);
  }
}
