import 'dart:io';

import 'package:concept/screens/gallery.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'image_confirm.dart';

class Image_Editor extends StatefulWidget {
  const Image_Editor({Key? key, this.imageFile}) : super(key: key);

  final Future<File?>? imageFile;

  @override
  State<Image_Editor> createState() => _Image_EditorState();
}

class _Image_EditorState extends State<Image_Editor> {
  // final Future<File?> imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => Gallery()));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF28B6ED),
                  ),
                )
              ],
            ),
            Text(
              "New Post",
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
                        builder: (context) => Image_Confirm_Screen(),
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
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height: 350,
            decoration: BoxDecoration(
              // shape: BoxShape.rectangle,
              color: Colors.black,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/editing.png"),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.crop_rotate,
                size: 24,
                color: Color(0xFF575757),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.exposure_outlined,
                size: 24,
                color: Color(0xFF575757),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.wb_sunny_outlined,
                size: 24,
                color: Color(0xFF575757),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.brightness_6_sharp,
                size: 24,
                color: Color(0xFF575757),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
              ),
              child: Text(
                "Cancel",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF393939)),
              ),
            ),
            // SizedBox(
            //   width: 30,
            // ),
            TextButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
              ),
              child: Text(
                "Done",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFA0AFF)),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
