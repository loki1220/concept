import 'dart:ui';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/splash.png",
              fit: BoxFit.fill,
            ),
            Center(
                child: Text(
              "Concept",
              style: GoogleFonts.rumRaisin(
                fontSize: 41,
                fontWeight: FontWeight.w500,
                /*color: LinearGradient(
                      colors: <Color>[Color(0xFF28B6ED),
                        Color(0xFF362345)]),*/
              ),
            ))
          ],
        ),
        splashIconSize: double.maxFinite,
        centered: true,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: HomePage(),
      ),
    );
  }
}
