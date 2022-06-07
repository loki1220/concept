import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Uint8List? _image;


  @override
  Widget build(BuildContext context) {

    final userName = Material(
      // borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 7,
        height: 40,
        //height: 2 * MediaQuery.of(context).size.height / 38,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xFFF6E8F8),
          // gradient: LinearGradient(
          //   colors: <Color>[
          //     Color(0xFF28B6ED),
          //     Color(0xFFE063FF),
          //   ],
          // ),
        ),
        child: MaterialButton(
            onPressed: () {},
            child: Container(
              child:    Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _image != null
                      ? CircleAvatar(
                    radius: 16,
                    backgroundImage: MemoryImage(_image!),
                    backgroundColor: Colors.red,
                  )
                      : const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        'https://i.stack.imgur.com/l60Hf.png'),
                    backgroundColor: Colors.red,
                  ),
                  Text("c/user",
                    style: GoogleFonts.roboto(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(
                      Icons.arrow_forward_ios,
                    color: Color(0xFF28B6ED),
                    size: 25,
                  ),
                ],
              ),
            )),
      ),
    );
    final language = Material(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 7,
        height: 40,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xFFF6E8F8),
          // gradient: LinearGradient(
          //   colors: <Color>[
          //     Color(0xFF28B6ED),
          //     Color(0xFFE063FF),
          //   ],
          // ),
        ),
        child: MaterialButton(
            onPressed: () {},
            child: Container(
              child:    Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Language",
                    style: GoogleFonts.roboto(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(
                      Icons.arrow_forward_ios,
                    color: Color(0xFF28B6ED),
                    size: 25,
                  ),
                ],
              ),
            )),
      ),
    );
    final personalInfo = Material(
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 7,
        height: 40,
        color: Color(0xFFF6E8F8),
        child: MaterialButton(
            onPressed: () {},
            child: Container(
              child:    Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Personal Information",
                    style: GoogleFonts.roboto(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(
                      Icons.arrow_forward_ios,
                    color: Color(0xFF28B6ED),
                    size: 25,
                  ),
                ],
              ),
            )),
      ),
    );
    final userAgree = Material(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 7,
        height: 40,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xFFF6E8F8),
          // gradient: LinearGradient(
          //   colors: <Color>[
          //     Color(0xFF28B6ED),
          //     Color(0xFFE063FF),
          //   ],
          // ),
        ),
        child: MaterialButton(
            onPressed: () {},
            child: Container(
              child:    Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("User Agreement",
                    style: GoogleFonts.roboto(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(
                      Icons.arrow_forward_ios,
                    color: Color(0xFF28B6ED),
                    size: 25,
                  ),
                ],
              ),
            )),
      ),
    );
    final contentPolicy = Material(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 7,
        height: 40,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xFFF6E8F8),
          // gradient: LinearGradient(
          //   colors: <Color>[
          //     Color(0xFF28B6ED),
          //     Color(0xFFE063FF),
          //   ],
          // ),
        ),
        child: MaterialButton(
            onPressed: () {},
            child: Container(
              child:    Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.file_copy,
                    color: Color(0xFF656565),
                    size: 25,
                  ),
                  Text(
                    "Content Policy",
                    style: GoogleFonts.roboto(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                ],
              ),
            )),
      ),
    );
    final termsofUse = Material(
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 7,
        height: 40,
        color: Color(0xFFF6E8F8),
        child: MaterialButton(
            onPressed: () {},
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.vpn_key_outlined,
                    color: Color(0xFF656565),
                    size: 25,
                  ),
                  Text(
                    "Terms of Use",
                    style: GoogleFonts.roboto(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                ],
              ),
            )),
      ),
    );
    final userAgree2 = Material(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 7,
        height: 40,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xFFF6E8F8),
          // gradient: LinearGradient(
          //   colors: <Color>[
          //     Color(0xFF28B6ED),
          //     Color(0xFFE063FF),
          //   ],
          // ),
        ),
        child: MaterialButton(
            onPressed: () {},
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person_rounded,
                    color: Color(0xFF656565),
                    size: 25,
                  ),
                  Text(
                    "Content Policy",
                    style: GoogleFonts.roboto(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                ],
              ),
            )),
      ),
    );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 1,
        shadowColor: Color(0xFFE063FF),
        leading:  IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            size: 28,
            color: Color(0xFF28B6ED),
          ),
        ),
        title:  Text(
          "Settings",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF000000),
          ),
        ),
       centerTitle: true,
        actions: [
          TextButton(
            child: Text(
              "Save",
              style: GoogleFonts.roboto(
                color: const Color(0xFF28B6ED),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const AudioConfirmScreen(),
              //   ),
              // );
            },
          ),

        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            children: [
              Text(
                "ACCOUNT SETTINGS",
              style: GoogleFonts.roboto(
                color: Color(0xFF000000),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              ),
            ],
          ),
          Column(
            children: [
              userName,
            ],
          ),
          Row(
            children: [
              Text(
                "VIEW OPTIONS ",
                style: GoogleFonts.roboto(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 120,
                  width: 6 * MediaQuery.of(context).size.width / 7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF6E8F8),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                    ),
                    child:  Center(
                      child: Column(
                        children: [
                          language,
                          personalInfo,
                          userAgree,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "ABOUT",
                style: GoogleFonts.roboto(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 120,
                  width: 6 * MediaQuery.of(context).size.width / 7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF6E8F8),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                    ),
                    child:  Center(
                      child: Column(
                        children: [
                          contentPolicy,
                          termsofUse,
                          userAgree2,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
