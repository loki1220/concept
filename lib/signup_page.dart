import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  bool _isLoading = false;

  bool _secureText = true;
  bool _securityText = true;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
      // onSaved: (value) {
      //   fullNameEditingController.text = value!;
      // },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: "Enter email/mobile number ",
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: _secureText,
      validator: (value) {
        RegExp regex = new RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter (Min. 8 letter, 1 Caps letter, 1 special letter, 1 Num)");
        }
      },
      // onSaved: (value) {
      //   fullNameEditingController.text = value!;
      // },
      textInputAction: TextInputAction.next,
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
        hintText: "Enter password",
      ),
    );

    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: _securityText,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      // onSaved: (value) {
      //   confirmPasswordEditingController.text = value!;
      // },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(_securityText
              ? Icons.panorama_fish_eye_sharp
              : Icons.remove_red_eye),
          onPressed: () {
            setState(() {
              _securityText = !_securityText;
            });
          },
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: "Confirm Password",
      ),
    );

    //registerbutton
    final registerButton = Material(
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
                      "Register",
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgregister.png"),
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
                        "Hello Concept ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000)),
                      ),
                      Text(
                        " maker",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome to the world",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF1F1F1F)),
                      ),
                      Text(
                        "of concepts!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF1F1F1F)),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  emailField,
                  SizedBox(height: 25),
                  passwordField,
                  SizedBox(height: 25),
                  confirmPasswordField,
                  SizedBox(height: 40),
                  registerButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
