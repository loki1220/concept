import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:concept/screens/uploading_screens/audio_confirm.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AudioEditor extends StatefulWidget {

  const AudioEditor({Key? key, required this.audioFile, this.audioPath}) : super(key: key);

  final File audioFile;
  final String? audioPath;


  @override
  State<AudioEditor> createState() => _AudioEditorState();
}

class _AudioEditorState extends State<AudioEditor> {

  final audioPlayer = AudioPlayer();

  String? audioPath;

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void iniState() {
    super.initState();
    _initAudio();

    // audioPlayer.onPlayerStateChanged.
  }

  _initAudio() async {
    final audio = await widget.audioFile;
    audioPlayer.onPlayerStateChanged;
    setState(() {
      audioPath = widget.audioPath;
    });
  }




  @override
  void dispose(){
    // audioPlayer.dispose();
    super.dispose();
  }

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
            child: Column(
              children: [
                Text(
                  "Add Cover Pic",
                  style: GoogleFonts.roboto(
                    color: Color(0xFF000000),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/sampleimg.png",
                  width: 150,
                    height: 150,
                    fit: BoxFit.cover ,
                  ),
                ),
                Slider(
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) async {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(formatTime(position)),
                    // Text(formatTime(duration - position))
                  ],
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 35,
            child: IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            iconSize: 50,
              onPressed: () async {
              //   if(isPlaying) {
              //     await audioPlayer.pause();
              //   } else {
              //     await audioPlayer.play()
              //   }
              },
            ),
          )
        ],
      ),
    );
  }
}
