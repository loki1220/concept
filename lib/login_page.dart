import 'package:concept/details.dart';
import 'package:concept/forgetpass.dart';
import 'package:concept/otp_page.dart';
import 'package:concept/signup_page.dart';
import 'package:concept/widget/mytextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  Widget _buildGoogleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 25,
          width: 25,
          child: Image.asset(
            "assets/gbutton.png",
            width: 25,
            height: 25,
          ),
        ),
        SizedBox(
          width: 25,
        ),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(),
                ),
              );
            },
            child: Container(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
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
        body: Container(
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
                    height: 200,
                    //color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyTextField(
                          obscureText: false,
                          isCenter: false,
                          txt: "Username",
                          controller: emailController,
                        ),
                        MyTextField(
                          obscureText: false,
                          isCenter: false,
                          txt: "Password",
                          controller: passwordController,
                          suffixbutton: IconButton(
                            icon: Icon(_secureText
                                ? Icons.panorama_fish_eye_sharp
                                : Icons.remove_red_eye),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "or continue with",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1F1F1F)),
                        ),
                        _buildGoogleButton(),
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
    );
  }
}
