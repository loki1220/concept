import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'audio_confirm.dart';

class AudioEditor extends StatefulWidget {
  const AudioEditor(
      {Key? key, required this.songModel, required this.audioPlayer}) 
      : super(key: key);
  
  final SongModel songModel;
  final AudioPlayer audioPlayer;

  @override
  State<AudioEditor> createState() => _AudioEditorState();
}

class _AudioEditorState extends State<AudioEditor> {


  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isPlaying = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playSong();
  }
  
  
  void playSong(){
    try{
      widget.audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.uri!)));
      widget.audioPlayer.play();
      _isPlaying = true;
    }on Exception{
      log("Cannot parse Song");
    }
    widget.audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // widget.audioPlayer.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                  ),
                  ),
                  Text(
                    "New Audio",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                    ),
                  ),
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
                          builder: (context) =>  AudioConfirmScreen(
                            audioPlayer: widget.audioPlayer,
                            songModel: widget.songModel,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 1,
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
              SizedBox(
                height: 30.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   CircleAvatar(
                    radius: 80,
                    child: Icon(
                      Icons.music_note,
                      size: 80,
                    ),
                  ),
                  SizedBox(height: 50,),
                  Text(
                    widget.songModel.displayNameWOExt,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    widget.songModel.artist.toString() == "<unknown>"
                        ?"Unknown Artist"
                        : widget.songModel.artist.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text(
                          _position.toString().split(".")[0]
                      ),
                      Expanded(
                        child: Slider(
                          activeColor: Color(0xFF515151),
                        inactiveColor: Color(0xFF28B6ED),
                        value: _position.inSeconds.toDouble(),
                        max: _duration.inSeconds.toDouble(),
                        min: Duration(microseconds: 0)
                            .inSeconds
                            .toDouble(),
                        onChanged: (value){
                          setState(() {
                            changeToseconds(value.toInt());
                            value = value;
                          });
                        },
                      ),),
                      Text(
                          _duration.toString().split(".")[0]
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.settings_backup_restore_rounded,
                          color: Color(0xFF515151),
                        ),
                        iconSize: 40,
                        onPressed: () async {},
                      ),
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Color(0xFF515151),
                        ),
                        iconSize: 40,
                        onPressed: () {
                          setState(() {
                            if(_isPlaying){
                              widget.audioPlayer.pause();
                            }else{
                              widget.audioPlayer.play();
                            }
                            _isPlaying = !_isPlaying;

                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.forward_10_outlined,
                          color: Color(0xFF515151),
                        ),
                        iconSize: 40,
                        onPressed: ()  {},
                      ),
                    ],
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void changeToseconds(int seconds){
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }

}






/*
import 'dart:developer';
import 'package:concept/screens/uploading_screens/audio_confirm.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AudioEditor extends StatefulWidget {

  const AudioEditor(
      {Key? key, required this.songModel, required this.audioPlayer})
      : super(key: key);
  final SongModel songModel;
  final AudioPlayer audioPlayer;

  @override
  State<AudioEditor> createState() => _AudioEditorState();
}

class _AudioEditorState extends State<AudioEditor> {
  Duration _duration = const Duration();
  Duration _position = const Duration();

  bool _isPlaying = false;

  @override
  void iniState() {
    super.initState();
    playSong();
  }

  void playSong(){
    try{
      widget.audioPlayer
          .setAudioSource(
          AudioSource.uri(
              Uri.parse(widget.songModel.uri!)
          )
      );
      widget.audioPlayer.play();
      _isPlaying = true;

    } on Exception{
      log("Cannot Parse Song");
    }
    widget.audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
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
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/sampleimg.png",
                  width: 150,
                    height: 150,
                    fit: BoxFit.cover ,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  widget.songModel.displayNameWOExt,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.songModel.artist.toString() == "<unknown>"
                  ?"Unknown Artist"
                  : widget.songModel.artist.toString(),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                ),
                Row(
                  children: [
                     Text(
                     _position.toString().split(".")[0]
                     ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        // max: duration.inSeconds.toDouble(),
                        value: 0.0,
                        onChanged: (value) {},
                      ),
                    ),
                    Text(
                      _duration.toString().split(".")[0]
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.settings_backup_restore_rounded,
                  color: Color(0xFF515151),
                ),
              iconSize: 40,
                onPressed: () async {},
              ),
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Color(0xFF515151),
                ),
              iconSize: 40,
                onPressed: () {
                  setState(() {
                    if(_isPlaying){
                      widget.audioPlayer.pause();
                    }else{
                      widget.audioPlayer.play();
                    }
                    _isPlaying = !_isPlaying;

                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.forward_10_outlined,
                  color: Color(0xFF515151),
                ),
              iconSize: 40,
                onPressed: ()  {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.stop_circle_outlined,
                    color: Color(0xFFF83A3A),
                    size: 40,
                  ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
*/
