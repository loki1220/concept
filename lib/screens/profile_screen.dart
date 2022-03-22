import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../resources/auth_methods.dart';
import 'login_page.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final _auth = FirebaseAuth.instance;

  void googleLogout() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    if (User != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          child: Text(
            "Sign Out",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            await AuthMethods().signOut();
            googleLogout();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
