import 'package:concept/login_page.dart';
import 'package:concept/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bgregister.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/home1.png"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: Container(
                    //color: Colors.grey,
                    height: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Explore your \n Ideas of your own ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Text(
                          " With a Patterns membership, gain access to \n thousands of curated mobile design \n  patterns ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff72707C)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 45,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.elliptical(15, 15),
                                        right: Radius.elliptical(15, 15))),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFFE074DC),
                                    Color(0xFFF133E9),
                                    Color(0xFFFE00F4),
                                  ],
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupPage(),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                ),
                                child: Text(
                                  "Register",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              height: 45,
                              width:
                                  6 * (MediaQuery.of(context).size.width / 19),
                              // margin: EdgeInsets.only(
                              //     top: 100, bottom: 5, left: 0, right: 1),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.elliptical(15, 15),
                                        right: Radius.elliptical(15, 15))),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    Color(0xFF19A4FF),
                                    Color(0xFF1AA4FF),
                                  ],
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  //elevation: 0,
                                ),
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Agree to Privacy Policy \n and Terms & Conditions",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF545353)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
