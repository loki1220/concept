import 'dart:io';

import 'package:concept/screens/gallery.dart';
import 'package:concept/widget/gradient_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class FeedScreen extends StatefulWidget {
  final AssetEntity? asset;

  const FeedScreen({
    Key? key,
    this.asset,
  }) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final picker = ImagePicker();
  // Future<File?>? imageFile;

  // final AssetEntity asset;

  Widget _slideButton() {
    return Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 13,
        height: 45,
        //height: 2 * MediaQuery.of(context).size.height / 38,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFE063FF),
              Color(0xFF5DB2EF),
            ],
          ),
        ),
        child: MaterialButton(
          onPressed: () {},
          child: Text(
            "Slides",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _imgButton() {
    return Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 13,
        height: 45,
        //height: 2 * MediaQuery.of(context).size.height / 38,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Color(0xFFE063FF),
          // gradient: LinearGradient(
          //   colors: <Color>[
          //     Color(0xFFE063FF),
          //   ],
          // ),
        ),
        child: MaterialButton(
          onPressed: () async {
// ### Add the next 2 lines ###
            final permitted = await PhotoManager.requestPermissionExtend();
            if (permitted == true) return;
// ######

            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => Gallery()),
            );
          },
          //     async {
          //   Navigator.of(context).pop();
          //   final pickedFile =
          //       await picker.pickImage(source: ImageSource.gallery);
          // },
          child: Text(
            "Video / Image",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _audioButton() {
    return Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 13,
        height: 45,
        //height: 2 * MediaQuery.of(context).size.height / 38,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Color(0xFF28B6ED),
          // gradient: LinearGradient(
          //   colors: <Color>[
          //     Color(0xFFE600EB),
          //     Color(0xFF1ABEFF),
          //   ],
          // ),
        ),
        child: MaterialButton(
          onPressed: () {},
          child: Text(
            "Audio",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _cancelButton() {
    return Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 22,
        height: 30,
        //height: 2 * MediaQuery.of(context).size.height / 38,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFE063FF),
              Color(0xFF5DB2EF),
            ],
          ),
        ),
        child: MaterialButton(
          onPressed: () {},
          child: Text(
            "Cancel",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _slideButton(),
                  _imgButton(),
                  _audioButton(),
                  _cancelButton(),
                ],
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(18)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GradientText("Concept",
                          style: GoogleFonts.rumRaisin(
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                          ),
                          colors: <Color>[
                            Color(0xFF3E6372),
                            Color(0xFF362345),
                          ])
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showCustomDialog(context);
                        },
                        icon: GradientIcon(
                          Icons.add_circle_outline_sharp,
                          30,
                          LinearGradient(
                            colors: <Color>[
                              Color(0XFF28B6ED),
                              Color(0XFFFA0AFF),
                            ],
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.pinkAccent,
            ),
          ],
        ),
      ),
/*
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GradientText(
          "Concept",
          style: GoogleFonts.rumRaisin(
            fontWeight: FontWeight.w400,
            fontSize: 28,
            //color: Colors.black,
          ),
          gradientDirection: GradientDirection.ttb,
          colors: <Color>[
            Color(0xFF3E6372),
            Color(0xFF362345),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showCustomDialog(context);
            },
            icon: GradientIcon(
              Icons.add_circle_outline_sharp,
              30,
              LinearGradient(
                colors: <Color>[
                  Color(0XFF28B6ED),
                  Color(0XFFFA0AFF),
                ],
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ],
      ),
*/
    );
  }
}
