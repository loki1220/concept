import 'package:concept/forgetpass.dart';
import 'package:concept/signup_page.dart';
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
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 25,
            width: 25,
            //margin: EdgeInsets.only(bottom: 20),
            //color: Colors.white,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0.0, 10.0),
                  color: Colors.grey.withOpacity(0.5),
                )
              ],
              shape: BoxShape.rectangle,
              // color: Color(0xffFCDB7F),
            ),
            child: Image.asset(
              "assets/gbutton.png",
              //color: Colors.white,
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
            //margin: EdgeInsets.only(bottom: 5),
            //color: Colors.white,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0.0, 10.0),
                    color: Colors.grey.withOpacity(0.5))
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

  Widget forgotPass() {
    return Padding(
      padding: const EdgeInsets.only(left: 175),
      child: RichText(
        //textAlign: TextAlign.end,
        text: TextSpan(
          text: "Forget password?",
          style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF332D3C)),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Forgetpass()));
            },
        ),
      ),
    );
  }

  Widget register() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
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
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
              ),
            ]),
      ),
    );
  }

  Widget user() {
    return Padding(
      padding: const EdgeInsets.only(right: 145),
      child: Text(
        "Enter the username",
        textAlign: TextAlign.start,
        style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2D2D3C)),
      ),
    );
  }

  Widget pass() {
    return Padding(
      padding: const EdgeInsets.only(right: 210),
      child: Text(
        "Password",
        textAlign: TextAlign.start,
        style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2D2D3C)),
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
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: _secureText,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(_secureText
              ? Icons.panorama_fish_eye_sharp
              : Icons.remove_red_eye),
          onPressed: () {
            setState(() {
              _secureText = !_secureText;
            });
          },
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        //hintText: "Password",
      ),
    );

    //loginbutton
    final loginButton = Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 9,
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
            )),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bglogin.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            //color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, right: 36.0, left: 36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Hello again!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF000000)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome back you've",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1F1F1F)),
                        ),
                        Text(
                          "been missed!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1F1F1F)),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    user(),
                    SizedBox(height: 5),
                    emailField,
                    SizedBox(height: 45),
                    pass(),
                    SizedBox(height: 5),
                    passwordField,
                    SizedBox(height: 18),
                    forgotPass(),
                    SizedBox(height: 20),
                    loginButton,
                    SizedBox(height: 50),
                    Text(
                      "or continue with",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1F1F1F)),
                    ),
                    SizedBox(height: 10),
                    _buildGoogleButton(),
                    SizedBox(height: 25),
                    register(),
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
