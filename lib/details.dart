import 'package:concept/widget/gradient_icon.dart';
import 'package:concept/widget/mytextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final userNameEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  selectImage() async {}

  @override
  Widget build(BuildContext context) {
    //nextbutton
    final nextButton = Container(
      child: Material(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 6 * MediaQuery.of(context).size.width / 28,
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
              child: /*_isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
                  :*/
                  Text(
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
      ),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/detailsbg.png",
              fit: BoxFit.fill,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: kToolbarHeight + 15,
                  ),
                  Text(
                    "Profile",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF525252)),
                  ),
                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: 130,
                          height: 130,
                          child: Center(
                            child: Container(
                              child: Icon(Icons.add_a_photo),
                              width: 125.0,
                              height: 125.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                // image: DecorationImage(
                                //   fit: BoxFit.fill,
                                //   image: NetworkImage(
                                //       "https://images.unsplash.com/photo-1594899756066-46964fff3add?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=170&q=80"),
                                // ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF28B6ED), Color(0xFFE063FF)],
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   top: 50,
                      //   child: Container(
                      //     // height: 30,
                      //     // width: 30,
                      //     decoration: (BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: Colors.white,
                      //     )),
                      //     child: IconButton(
                      //       onPressed: selectImage,
                      //       icon: const Icon(Icons.add_a_photo),
                      //       iconSize: 16,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          MyTextField(
                            obscureText: false,
                            isCenter: true,
                            controller: userNameEditingController,
                            fieldname: "User Name",
                          ),
                          MyTextField(
                            obscureText: true,
                            isCenter: true,
                            controller: passwordEditingController,
                            fieldname: "Password",
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
                          ),
                          MyTextField(
                            obscureText: true,
                            isCenter: true,
                            controller: confirmPasswordEditingController,
                            fieldname: "Confirm Password",
                            validator: (value) {
                              if (confirmPasswordEditingController.text !=
                                  passwordEditingController.text) {
                                return "Password don't match";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        nextButton,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
