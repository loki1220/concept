import 'package:concept/screens/gallery.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../layouts/mobile_screen_layout.dart';

class Image_Confirm_Screen extends StatefulWidget {
  const Image_Confirm_Screen({Key? key}) : super(key: key);

  @override
  State<Image_Confirm_Screen> createState() => _Image_Confirm_ScreenState();
}

class _Image_Confirm_ScreenState extends State<Image_Confirm_Screen> {
  bool isLoading = false;

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;

  final TextEditingController _descriptionController = TextEditingController();

  // Widget buildSwitch() => Transform.scale(
  //       scale: 1,
  //       child: Switch.adaptive(
  //         thumbColor: MaterialStateProperty.all(Colors.red),
  //         trackColor: MaterialStateProperty.all(Colors.orange),
  //
  //         // activeColor: Colors.blueAccent,
  //         // activeTrackColor: Colors.blue.withOpacity(0.4),
  //         // inactiveThumbColor: Colors.orange,
  //         // inactiveTrackColor: Colors.black87,
  //         splashRadius: 10,
  //         value: value,
  //         onChanged: (value) => setState(() => this.value = value),
  //       ),
  //     );

  Widget buildToggleSwitch1() => Transform.scale(
        scale: 0.7,
        child: CupertinoSwitch(
          thumbColor: Color(0xFFFFFFFF),
          trackColor: Color(0xFFFA0AFF),
          activeColor: Color(0xFF28B6ED),
          value: value1,
          onChanged: (value) => setState(() => this.value1 = value),
        ),
      );
  Widget buildToggleSwitch2() => Transform.scale(
        scale: 0.7,
        child: CupertinoSwitch(
          thumbColor: Color(0xFFFFFFFF),
          trackColor: Color(0xFFFA0AFF),
          activeColor: Color(0xFF28B6ED),
          value: value2,
          onChanged: (value) => setState(() => this.value2 = value),
        ),
      );
  Widget buildToggleSwitch3() => Transform.scale(
        scale: 0.7,
        child: CupertinoSwitch(
          thumbColor: Color(0xFFFFFFFF),
          trackColor: Color(0xFFFA0AFF),
          activeColor: Color(0xFF28B6ED),
          value: value3,
          onChanged: (value) => setState(() => this.value3 = value),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight - 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            MobileScreenLayout()));
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xFF28B6ED),
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            MobileScreenLayout()));
                              },
                              child: GradientText(
                                "Back",
                                colors: [Color(0xFF5DB2EF), Color(0xFFFA0AFF)],
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                                gradientDirection: GradientDirection.ttb,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "New Post",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Color(0xFF000000),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            isLoading
                ? const LinearProgressIndicator()
                : const Padding(padding: EdgeInsets.only(top: 0.0)),
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
            Container(
              // color: Colors.black,
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // if (photoUrl != "")
                      // CircleAvatar(
                      //     backgroundImage:
                      //         AssetImage("assets/loki.jpg") /*NetworkImage(photoUrl)*/),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                              hintText: "Write a caption...",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9E9E9E),
                              ),
                              border: InputBorder.none),
                          maxLines: 5,
                        ),
                      ),
                      Container(
                        height: 90.0,
                        width: 80.0,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                                image: AssetImage(
                                    "assets/editing.png") /*MemoryImage(_file!)*/,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "Settings",
                  //         style: GoogleFonts.roboto(
                  //           color: Color(0xFF525252),
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Divider(),
                  Container(
                    color: Color(0xFFC4C4C4).withOpacity(0.2),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 20,
                                          color: Color(0xFF525252),
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Location",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Color(0xFF525252),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              buildToggleSwitch1(),
                              // GFToggle(
                              //   onChanged: null,
                              //   value: true,
                              //   type: GFToggleType.ios,
                              // )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Icon(
                                          Icons.ios_share,
                                          size: 20,
                                          color: Color(0xFF525252),
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Share",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Color(0xFF525252),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              buildToggleSwitch2(),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Icon(
                                          Icons.insert_comment,
                                          size: 20,
                                          color: Color(0xFF525252),
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Comments",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Color(0xFF525252),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              buildToggleSwitch3(),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 42,
                        width: 5 * (MediaQuery.of(context).size.width / 17),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.elliptical(15, 15),
                                  right: Radius.elliptical(15, 15))),
                          color: Color(0xFFE063FF),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                          ),
                          child: Text(
                            "Draft",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 42,
                        width: 5 * (MediaQuery.of(context).size.width / 17),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.elliptical(15, 15),
                                  right: Radius.elliptical(15, 15))),
                          color: Color(0xFF5DB2EF),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            "Post",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF)),
                          ),
                        ),
                      ),
                    ],
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
