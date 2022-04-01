import 'dart:async';

import 'package:concept/screens/signup_page.dart';
import 'package:concept/screens/started_page.dart';
import 'package:concept/widget/circular_indicator.dart';
import 'package:concept/widget/mytextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../layouts/mobile_screen_layout.dart';
import 'details.dart';
import 'forgetpass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool _secureText = true;

  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // //creating the timer that stops the loading after 15 secs
  // void startTimer() {
  //   Timer.periodic(const Duration(seconds: 1), (t) {
  //     setState(() {
  //       _isLoading = false; //set loading to false
  //     });
  //     t.cancel(); //stops the timer
  //   });
  // }
  //
  // @override
  // void initState() {
  //   startTimer(); //start the timer on loading
  //   super.initState();
  // }

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // login function
  void signIn(String email, String password) async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
              (uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Started_Page(),
                  ),
                ),
                // Get.to(
                //   Started_Page(),
                //   /* Details(
                //     assetImage: 'assets/sliderstar.png',
                //   ),*/
                // ),
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => MobileScreenLayout())),
              },
            );
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Fluttertoast.showToast(msg: "msg", toastLength: Toast.LENGTH_SHORT);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Widget _buildGoogleButton() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Container(
  //         height: 25,
  //         width: 25,
  //         child: GestureDetector(
  //           onTap: () async {
  //             await signInWithGoogle();
  //             setState(() {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => MobileScreenLayout(),
  //                 ),
  //               );
  //             });
  //           },
  //           child: Image.asset(
  //             "assets/gbutton.png",
  //             width: 25,
  //             height: 25,
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         width: 25,
  //       ),
  //       Container(
  //         height: 25,
  //         width: 25,
  //         child: Image.asset(
  //           "assets/fbutton.png",
  //           width: 25,
  //           height: 25,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget forgotPass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RichText(
          text: TextSpan(
            text: "Forget password?",
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF332D3C),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                FocusScope.of(context).unfocus();
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forgetpass()));
              },
          ),
        ),
      ],
    );
  }

  Widget register() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
              text: "Not yet joined?",
              style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2A2F3B)),
              children: [
                TextSpan(
                  text: "Register now",
                  //textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0096D1)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      FocusScope.of(context).unfocus();
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                ),
              ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //loginbutton
    final loginButton = Container(
      child: Material(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 6 * MediaQuery.of(context).size.width / 9,
          height: 45,
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
              signIn(emailController.text, passwordController.text);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Details(
              //       assetImage: 'assets/sliderstar.png',
              //     ),
              //   ),
              // );
              //  FocusScope.of(context).unfocus();
            },
            child: Container(
              child: _isLoading
                  ? const Center(
                      child: Circular_Indicator(
                          // backgroundColor: Color(0xFFFFFFFF),
                          // strokeWidth: 3.0,
                          // color: Colors.black54,
                          ),
                    )
                  : Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFFFFF)),
                    ),
            ),
          ),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            // setState(() {
            //   FocusScope.of(context).;
            // });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bglogin.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Hello again!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              height: 3,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF000000)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Welcome back you've \n been missed!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1F1F1F)),
                        ),
                      ],
                    ),
                    Container(
                      height: 240,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyTextField(
                            obscureText: false,
                            isCenter: false,
                            autofocus: false,
                            txt: "Username or Email address",
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
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
                          ),
                          MyTextField(
                            autofocus: false,
                            obscureText: _secureText,
                            isCenter: false,
                            txt: "Password",
                            controller: passwordController,
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Password must");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 6 Character)");
                              }
                            },
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                            suffixbutton: IconButton(
                              icon: Icon(_secureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _secureText = !_secureText;
                                });
                              },
                              color: Colors.grey,
                            ),
                          ),
                          forgotPass(),
                        ],
                      ),
                    ),
                    loginButton,
                    Container(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(
                          //   "or continue with",
                          //   textAlign: TextAlign.center,
                          //   style: GoogleFonts.roboto(
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.w400,
                          //       color: Color(0xFF1F1F1F)),
                          // ),
                          //_buildGoogleButton(),
                          register(),
                        ],
                      ),
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
