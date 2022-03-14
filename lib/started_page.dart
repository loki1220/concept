import 'package:concept/layouts/mobile_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Started_Page extends StatefulWidget {
  const Started_Page({Key? key}) : super(key: key);

  @override
  _Started_PageState createState() => _Started_PageState();
}

class _Started_PageState extends State<Started_Page> {
  Widget _startbutton() {
    return Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 15,
        height: 28,
        //height: 2 * MediaQuery.of(context).size.height / 38,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF1ABEFF),
              Color(0xFFE600EB),
            ],
          ),
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MobileScreenLayout(),
              ),
            );
          },
          child: Text(
            "Get Started",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFFFFFF),
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
          height: 350,
          width: MediaQuery.of(context).size.width * 0.80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xFFFFFFFF).withOpacity(0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [Image.asset("assets/started.png")],
              ),
              Column(
                children: [
                  Text(
                    " Mart is all set to enter the ",
                    style: GoogleFonts.mansalva(
                      color: Color(0xFF0099D6),
                      fontWeight: FontWeight.w400,
                      fontSize: 20.48,
                      wordSpacing: 2,
                    ),
                  ),
                  Text(
                    " magical concept of learning!",
                    style: GoogleFonts.mansalva(
                      color: Color(0xFFEE00F3),
                      fontWeight: FontWeight.w400,
                      fontSize: 20.48,
                      wordSpacing: 2,
                    ),
                  ),
                ],
              ),
              _startbutton(),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/bg.png",
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildContainer(),
            ],
          ),
        ],
      ),
    );
  }
}
