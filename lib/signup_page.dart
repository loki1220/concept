import 'package:concept/otp_page.dart';
import 'package:concept/widget/mytextfield.dart';
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

  final numEditingController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Otp_Page(),
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
                      "Next",
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
        //resizeToAvoidBottomInset: true,
        body: Container(
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
                    isCenter: true,
                    controller: numEditingController,
                    fieldname: "Enter the mobile number",
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter a number");
                      }
                      ;
                      if (value.length < 10) {
                        return ("Enter 10 digits");
                      }
                    },
                    onSaved: (value) {
                      numEditingController.text = value!;
                    },
                  ),
                  SizedBox(height: 50),
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
