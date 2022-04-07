import 'dart:io';
import 'package:concept/screens/gallery.dart';
import 'package:concept/screens/video_confirm.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';

import 'image_confirm.dart';

class Video_Editor extends StatefulWidget {
  const Video_Editor({Key? key, required this.videoFile}) : super(key: key);

  final Future<File?> videoFile;

  @override
  State<Video_Editor> createState() => _Video_EditorState();
}

class _Video_EditorState extends State<Video_Editor> {

  VideoPlayerController? _controller;

  bool initialized = false;


  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _initVideo() async {
    final video = await widget.videoFile;
    _controller = VideoPlayerController.file(video!)
    // Play the video again when it ends
      ..setLooping(true)
    // initialize the controller and notify UI when done
      ..initialize().then((_) => setState(() => initialized = true));
  }

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
                            builder: (context) => Video_Confirm_Screen(
                              videoFile: widget.videoFile,
                            ),
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
              child: Stack(
                children: [
                  Container(
                    height: 350,
                   child: Center(
                     child: AspectRatio(
                       aspectRatio: _controller!.value.aspectRatio,
                       child: VideoPlayer(_controller!),
                     ),
                   ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100,),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_controller!.value.isPlaying) {
                              _controller!.pause();
                            } else {
                              _controller!.play();
                            }
                          });
                        },
                        icon: Icon(
                          _controller!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Color(0xFFFFFFFF).withOpacity(0.75),size: 70,),
                      ),
                    ),
                  ),
                ],
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
