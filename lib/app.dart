import 'package:flutter/material.dart';
import 'package:progress_pal/pages/splash_screen.dart';

class ProgressPalApp extends StatelessWidget {

  const ProgressPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Pal',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 25,vertical: 8,
          ),
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          
          fillColor: Colors.grey.shade800,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey.shade600),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey.shade600),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
