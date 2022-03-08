import 'package:concept/widget/gradient_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  selectImage() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Profile",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF525252)),
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("loki.jpg"),
                  /*MemoryImage(_image!)*/
                  backgroundColor: Colors.white,
                  /*child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF9FB6EC), Color(0xFFEBA5F4)],
                      ),
                    ),
                  ),*/
                ),
                /*CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(
                  'https://i.stack.imgur.com/l60Hf.png'),

            ),*/
                Positioned(
                  bottom: -0,
                  left: 65,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: (BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    )),
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                      iconSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
