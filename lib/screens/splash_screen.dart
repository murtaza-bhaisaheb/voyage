import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voyage/screens/home_screen.dart';
import 'package:voyage/screens/on_boarding_screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {

  static const String routeName = "splash-screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1, milliseconds: 500), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if(user == null){
          Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
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