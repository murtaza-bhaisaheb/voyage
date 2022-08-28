import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/screens/splash_screen.dart';
import 'package:voyage/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voyage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: AppColors.charcoal,
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          )
      ),
      home: const SplashScreen(),
    );
  }
}