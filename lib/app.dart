import 'package:flutter/material.dart';
import 'package:progress_pal/ui/pages/splash_screen.dart';

const colorGreen = Color.fromRGBO(33, 191, 115, 1);

class ProgressPalApp extends StatelessWidget {
  const ProgressPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Pal',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: customSwatch,
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: Colors.grey,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 8,
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

Color customColor = Color.fromRGBO(10, 188, 102, 1);

MaterialColor customSwatch = MaterialColor(
  customColor.value,
  <int, Color>{
    50: customColor.withOpacity(0.1),
    100: customColor.withOpacity(0.2),
    200: customColor.withOpacity(0.3),
    300: customColor.withOpacity(0.4),
    400: customColor.withOpacity(0.5),
    500: customColor.withOpacity(0.6),
    600: customColor.withOpacity(0.7),
    700: customColor.withOpacity(0.8),
    800: customColor.withOpacity(0.9),
    900: customColor.withOpacity(1.0),
  },
);
