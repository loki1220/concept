import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Otp_Page extends StatefulWidget {
  const Otp_Page({Key? key}) : super(key: key);

  @override
  _Otp_PageState createState() => _Otp_PageState();
}

class _Otp_PageState extends State<Otp_Page> {
  // List<int> firstRow = [1, 2, 3], seondRow = [4, 5, 6], thirdRow = [7, 8, 9];

  int pinLength = 6;

  String pinEntered = "";

  String workingPin = "";

  Widget _sendagain() {
    return RichText(
      text: TextSpan(
        text: "Send again",
        style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFF28B6ED)),
        recognizer: TapGestureRecognizer()..onTap = null,
      ),
    );
  }

  Widget _textFieldOTP({bool? first, last}) {
    return Container(
      height: 42,
      width: 1 * MediaQuery.of(context).size.width / 10,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          cursorColor: Colors.black,
          cursorHeight: 17,
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }

  Widget numberButton(int item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.toString(),
            style: GoogleFonts.roboto(
              color: Color(0xFF6C6C6C),
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xFFFFFFFF).withOpacity(0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberButton(1),
                  numberButton(2),
                  numberButton(3),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "-",
                          style: GoogleFonts.roboto(
                            color: Color(0xFF6C6C6C),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberButton(4),
                  numberButton(5),
                  numberButton(6),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ",",
                          style: GoogleFonts.roboto(
                            color: Color(0xFF6C6C6C),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberButton(7),
                  numberButton(8),
                  numberButton(9),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.backspace_outlined),
                    color: Color(0xFF6C6C6C),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Opacity(
                      opacity: 0,
                      child: AbsorbPointer(
                        absorbing: true,
                        child: numberButton(0),
                      ),
                    ),
                    numberButton(0),
                    Opacity(
                      opacity: 0,
                      child: AbsorbPointer(
                        absorbing: true,
                        child: numberButton(0),
                      ),
                    ),
                    Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF28B6ED),
                            Color(0xFF6998F3),
                            Color(0xFF6F63FF),
                          ],
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward),
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //verifybutton
    final verifyButton = Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
          width: 6 * MediaQuery.of(context).size.width / 10,
          height: 37,
          //height: 2 * MediaQuery.of(context).size.height / 38,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF28B6ED),
                Color(0xFFE063FF),
              ],
            ),
          ),
          child: MaterialButton(
            onPressed: null,
            child: Text(
              "Verify & Submit",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF)),
            ),
          )),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/bg.png",
              fit: BoxFit.fill,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Enter OTP",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F1F1F)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _textFieldOTP(first: true, last: false),
                    _textFieldOTP(first: false, last: false),
                    _textFieldOTP(first: false, last: false),
                    _textFieldOTP(first: false, last: false),
                    _textFieldOTP(first: false, last: false),
                    _textFieldOTP(first: false, last: true),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Haven't received a code yet?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF000000)),
                    ),
                    _sendagain(),
                  ],
                ),
                verifyButton,
                Container(child: _buildContainer()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
