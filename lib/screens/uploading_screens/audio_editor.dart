import 'package:concept/screens/uploading_screens/audio_confirm.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AudioEditor extends StatefulWidget {
  const AudioEditor({Key? key}) : super(key: key);

  @override
  State<AudioEditor> createState() => _AudioEditorState();
}

class _AudioEditorState extends State<AudioEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: <Widget> [
          SizedBox(
            height: kToolbarHeight - 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                     Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF28B6ED),
                    ),
                  )
                ],
              ),
              Text(
                "New Audio",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    child: GradientText(
                      "Next",
                      colors: <Color>[
                        Color(0xFF5DB2EF),
                        Color(0xFFFA0AFF),
                      ],
                      gradientDirection: GradientDirection.ttb,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AudioConfirmScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF28B6ED),
                  Color(0xFFE063FF),
                ],
              ),
            ),
          ),
        ),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 28),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width / 1.5,
              color: Colors.black,
              child: Text(
                "Add Cover Pic",
                style: GoogleFonts.roboto(
                  color: Color(0xFF000000),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
