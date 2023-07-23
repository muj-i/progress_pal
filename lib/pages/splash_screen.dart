
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_pal/pages/login_page.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';
import 'package:progress_pal/utils/assets_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToLoginPage();
    super.initState();
  }

  void navigateToLoginPage() {
    Future.delayed(Duration(seconds: 1)).then(
      (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
            AssetUtils.logoSVG,
            width: 90,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
