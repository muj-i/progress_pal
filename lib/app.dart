import 'package:flutter/material.dart';
import 'package:progress_pal/ui/pages/splash_screen.dart';

class ProgressPalApp extends StatelessWidget {
  const ProgressPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Pal',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
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
