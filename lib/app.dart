import 'package:flutter/material.dart';
import 'package:progress_pal/ui/pages/splash_screen.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';

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
          prefixIconColor:  myColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 8,
          ),
          
          hintStyle: TextStyle(color: myColor),
         //labelStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey[50],
          focusColor: myColor,
          
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:  BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:  BorderSide(color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
              // Customize the error border color
            ),
            focusedErrorBorder: OutlineInputBorder(
              
              borderRadius: BorderRadius.circular(20.0),
              
              borderSide: const BorderSide(
               color: Color.fromARGB(255, 255, 0, 0)
                ),
            ),
            errorStyle: TextStyle(color: Color.fromARGB(255, 255, 0, 0))
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Color customColor = Color.fromARGB(255, 10, 29, 66);

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
