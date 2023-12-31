import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/ui/pages/auth/login_page.dart';
import 'package:progress_pal/ui/pages/bottom_nav_base_page.dart';
import 'package:progress_pal/ui/utils/assets_utils.dart';
import 'package:progress_pal/ui/widgets/sceen_backgrounds.dart';

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
    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        final bool isLoggedIn = await AuthUtils.checkIfUserLoggedIn();

        if (mounted) {
          Get.offAll(
              () => isLoggedIn ? const BottomNavBasePage() : const LoginPage());
        }
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
            width: 125,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
