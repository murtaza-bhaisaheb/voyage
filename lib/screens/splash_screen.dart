import 'dart:async';

import 'package:flutter/material.dart';
import 'package:voyage/screens/on_boarding_screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {

  static String routeName = "/sign";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo-500.png',
          width: screenSize.shortestSide / 3.5,
        ),
      ),
    );
  }
}