import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voyage/providers/auth_provider.dart';
import 'package:voyage/screens/home_screen.dart';
import 'package:voyage/screens/on_boarding_screens/welcome_screen.dart';
import 'package:voyage/screens/splash_screen.dart';
import 'package:voyage/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Voyage',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: AppColors.charcoal,
            textTheme: GoogleFonts.nunitoTextTheme(
              Theme.of(context).textTheme,
            )),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName : (context) => const SplashScreen(),
          HomeScreen.routeName : (context) => const HomeScreen(),
          WelcomeScreen.routeName : (context) => const WelcomeScreen(),
        },
      ),
    );
  }
}