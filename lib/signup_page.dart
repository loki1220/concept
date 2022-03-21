import 'package:concept/login_page.dart';
import 'package:concept/resources/auth_methods.dart';
import 'package:concept/widget/circular_indicator.dart';
import 'package:concept/widget/mytextfield.dart';
import 'package:concept/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  bool _secureText = true;
  bool _securityText = true;

  // editing Controller
  final fullnameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    fullnameEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      fullname: fullnameEditingController.text,
      email: emailEditingController.text,
      password: passwordEditingController.text,
    );

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    //registerbutton
    final registerButton = Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 12,
        height: 45,
        //height: 2 * MediaQuery.of(context).size.height / 38,
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
              // if(fullnameEditingController.text.isEmpty || fullnameEditingController.text.length<3){
              //   return;
              // }else if(emailEditingController.text.isEmpty ){
              //   return;
              // }else if(passwordEditingController.text.isEmpty || passwordEditingController.)
              if (_formKey.currentState!.validate()) {
                // final snackBar = SnackBar(content: Text('Submitting form'));
                // _scaffoldKey.currentState!.showSnackBar(snackBar);
                signUpUser();
              }

              FocusScope.of(context).unfocus();
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
                      "Sign up",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFFFFF)),
                    ),
            )),
      ),
    );

    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bgregister.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Hello Concept \n maker",
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
                            "Welcome to the world \n of concepts!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1F1F1F)),
                          ),
                        ],
                      ),
                      MyTextField(
                        autofocus: false,
                        obscureText: false,
                        isCenter: true,
                        controller: fullnameEditingController,
                        fieldname: "Enter Name",
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        helperText: "",
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          fullnameEditingController.text = value!;
                        },
                        maxLength: 30,
                      ),
                      MyTextField(
                        autofocus: false,
                        obscureText: false,
                        isCenter: true,
                        controller: emailEditingController,
                        fieldname: "Enter email address",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        helperText: "",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          fullnameEditingController.text = value!;
                        },
                      ),
                      MyTextField(
                        autofocus: false,
                        obscureText: _secureText,
                        // key: _formKey,
                        isCenter: true,
                        controller: passwordEditingController,
                        fieldname: "password",
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          RegExp regex = new RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
                          if (value!.isEmpty) {
                            return ("Password is must for signup");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter (Min. 8 letter, 1 Caps letter, 1 special letter, 1 Num)");
                          }
                        },
                        onSaved: (value) {
                          passwordEditingController.text = value!;
                        },
                        suffixbutton: IconButton(
                          icon: Icon(
                            _secureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _secureText = !_secureText;
                            });
                          },
                        ),
                      ),
                      MyTextField(
                        autofocus: false,
                        obscureText: _securityText,
                        isCenter: true,
                        controller: confirmPasswordEditingController,
                        fieldname: "Confirm Password",
                        textInputAction: TextInputAction.done,
                        helperText: "",
                        validator: (value) {
                          if (confirmPasswordEditingController.text !=
                              passwordEditingController.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          fullnameEditingController.text = value!;
                        },
                        suffixbutton: IconButton(
                          icon: Icon(
                            _securityText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _securityText = !_securityText;
                            });
                          },
                        ),
                      ),
                      registerButton,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
