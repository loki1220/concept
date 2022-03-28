import 'package:concept/widget/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({Key? key}) : super(key: key);

  @override
  _ForgetpassState createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // firebase
  final _auth = FirebaseAuth.instance;

  //Controllers
  TextEditingController emailController = TextEditingController();

  Widget _backtologin() {
    return RichText(
      text: TextSpan(
        text: "Back to Login",
        style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2F2F3C)),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            await Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
      ),
    );
  }

  Widget _facebookButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 25,
          width: 25,
          child: Image.asset(
            "assets/fbutton.png",
            width: 25,
            height: 25,
          ),
        ),
      ],
    );
  }

  void sendpasswordresetemail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) => {
          Fluttertoast.showToast(
              msg: "Password Reset email link is been sent ,Success"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage())),
        });
  }

  @override
  Widget build(BuildContext context) {
    //forgetbutton
    final forgetButton = Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 14,
        height: 40,
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
          onPressed: () {
            _auth.sendPasswordResetEmail(email: emailController.text);
            Fluttertoast.showToast(
                msg: "Check your Email", toastLength: Toast.LENGTH_SHORT);
            Navigator.of(context).pop();
          },
          child: Container(
            child: Text(
              "Next",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF)),
            ),
          ),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bglogin.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/lock.png"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            height: 450,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Trouble in logging in?",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      height: 2,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF000000)),
                                ),
                                Text(
                                  "Enter your username or email address and \n we’ll send you a link to get back to your \n account. ",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF1F1F1F)),
                                ),
                                MyTextField(
                                  autofocus: false,
                                  obscureText: false,
                                  isCenter: true,
                                  txt: "Email address",
                                  controller: emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Please Enter Your Email");
                                    }
                                    // reg expression for email validation
                                    if (!RegExp(
                                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return ("Please Enter a valid email");
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    emailController.text = value!;
                                  },
                                  fieldname: "Email address",
                                ),
                                forgetButton,
                                Text(
                                  "Need more help?",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF514860)),
                                ),
                                _facebookButton(),
                                _backtologin(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
