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
    return Scaffold(
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
          padding: EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset("assets/home1.png"),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 290),
                //width: 280,
                //height: 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Explore your ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Text(
                      "Ideas of your own",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      " With a Patterns membership, gain access to  ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff72707C)),
                    ),
                    Text(
                      "thousands of curated mobile design  ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff72707C)),
                    ),
                    Text(
                      " patterns ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff72707C)),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height:
                              1.4 * (MediaQuery.of(context).size.height / 20),
                          width: 6 * (MediaQuery.of(context).size.width / 15),
                          margin: EdgeInsets.only(top: 100, left: 0, right: 10),
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
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                          width: 15,
                        ),
                        Container(
                          height:
                              1.4 * (MediaQuery.of(context).size.height / 20),
                          width: 6 * (MediaQuery.of(context).size.width / 15),
                          margin: EdgeInsets.only(
                              top: 100, bottom: 5, left: 0, right: 1),
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
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
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
                    // SizedBox(
                    //   height: 35,
                    // ),
                    Text(
                      "Agree to Privacy Policy",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF545353)),
                    ),
                    Text(
                      " and Terms & Conditions",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF545353)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
