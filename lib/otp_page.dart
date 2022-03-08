import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Otp_Page extends StatefulWidget {
  const Otp_Page({Key? key}) : super(key: key);

  @override
  _Otp_PageState createState() => _Otp_PageState();
}

class _Otp_PageState extends State<Otp_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Enter OTP",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F1F1F)),
            ),
          ],
        ),
      ),
    );
  }
}
