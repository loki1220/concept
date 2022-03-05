import 'package:concept/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({Key? key}) : super(key: key);

  @override
  _ForgetpassState createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  TextEditingController emailController = TextEditingController();

  Widget _backtologin() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
        text: TextSpan(
          text: "Back to Login",
          //textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2F2F3C)),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
        ),
      ),
    );
  }

  Widget _facebookButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 25,
            width: 25,
            //margin: EdgeInsets.only(bottom: 5),
            //color: Colors.white,
            decoration: BoxDecoration(
              boxShadow: [
                // BoxShadow(
                //     blurRadius: 10,
                //     spreadRadius: 1,
                //     offset: Offset(0.0, 10.0),
                //     color: Colors.grey.withOpacity(0.5))
              ],
              //shape: BoxShape.rectangle,
              // color: Color(0xffFCDB7F),
            ),
            child: Image.asset(
              "assets/fbutton.png",
              //color: Colors.white,
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //emailField
    final emailField = TextFormField(
      //autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: "           Phone number or email address",
      ),
    );

    //forgetbutton
    final forgetButton = Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 14,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF28B6ED),
              Color(0xFFE063FF),
            ],
          ),
        ),
        child: MaterialButton(
            // padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: null,
            child: Container(
              child: Text(
                "Next",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF)),
              ),
            )),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bglogin.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 100, right: 35, left: 35),
          child: Stack(
            children: [
              Column(
                children: [
                  Image.asset("assets/lock.png"),
                  SizedBox(
                    height: 35,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Trouble in logging in?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Enter your username or email address and  ",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1F1F1F)),
                          ),
                          Text(
                            " we’ll send you a link to get back to your",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1F1F1F)),
                          ),
                          Text(
                            "account.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1F1F1F)),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Phone number or email address",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF2E2D3C)),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      emailField,
                      SizedBox(height: 30),
                      forgetButton,
                      SizedBox(height: 30),
                      Text(
                        "Need more help?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF514860)),
                      ),
                      _facebookButton(),
                      SizedBox(height: 50),
                      _backtologin(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
