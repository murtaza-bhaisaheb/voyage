import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyage/providers/auth_provider.dart';
import 'package:voyage/screens/on_boarding_screens/welcome_screen.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = "home-screen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            auth.error = null;

            FirebaseAuth.instance.signOut().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(context, WelcomeScreen.routeName, (route) => false),
                );
          },
          child: const Text("Log out"),
        ),
      ),
    );
  }
}
