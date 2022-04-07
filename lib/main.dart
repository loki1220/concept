import 'dart:ui';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:concept/layouts/mobile_screen_layout.dart';
import 'package:concept/providers/user_providers.dart';
import 'package:concept/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'layouts/responsive_layouts.dart';

Future<void> main() async {
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
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future has not been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return AnimatedSplashScreen(
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
            );
          },
        ),
      ),
    );
  }
}

//Loki cloned service updated on 07/04/2022
