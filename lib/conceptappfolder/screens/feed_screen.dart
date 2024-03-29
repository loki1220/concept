import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concept/screens/uploading_screens/audio_list.dart';
import 'package:concept/screens/uploading_screens/gallery.dart';
import 'package:concept/widget/gradient_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../widget/global_variables.dart';
import '../widget/post_card.dart';

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

  
   // audioPlayer = AudioPlayer();
    AudioPlayer? audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;


   final picker = ImagePicker();

   var audioPath;

   // PlatformFile? mp3;
   File? audioFile;

  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }


  @override
  void dispose(){
    audioPlayer?.dispose();

    super.dispose();
  }


    playAudioFromLocalStorage(path) async {
      int response = await audioPlayer!.play(path, isLocal: true);
      if (response == 1) {
        // success
      } else {
        print('Some error occured in playing from storage!');
      }
    }
    pauseAudio() async {
      int response = await audioPlayer!.pause();
      if (response == 1) {
        // success

      } else {
        print('Some error occured in pausing');
      }
    }
    stopAudio() async {
      int response = await audioPlayer!.stop();
      if (response == 1) {
        // success

      } else {
        print('Some error occured in stopping');
      }
    }
    resumeAudio() async {
      int response = await audioPlayer!.resume();
      if (response == 1) {
        // success

      } else {
        print('Some error occured in resuming');
      }
    }


  // void openFile (PlatformFile file) {
  //   OpenFile.open(file.path!);
  // }

  // Future setAudio() async{
  //   //Repeat song when completed
  //   audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  //
  //   //Load audio from file
  //   final result = await FilePicker.platform.pickFiles();
  //
  //   if (result != null){
  //     final audioFile = File(result.files.single.path!);
  //     audioPlayer.setUrl(audioFile.path, isLocal: true);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context)=>
  //             AudioEditor(
  //               audioFile: File(audioFile.path),
  //             ),
  //       ),
  //     );
  //   }
  // }




  // void _pickFiles() async {
  //   _resetState();
  //   try {
  //     audioFile = null;
  //     picker = (await FilePicker.platform.pickFiles(
  //       type: FileType.audio,
  //       onFileLoading: (FilePickerStatus status) => print(status),
  //       allowedExtensions: ['mp3'],
  //     ))
  //         ?.files;
  //   } on PlatformException catch (e) {
  //     _logException('Unsupported operation' + e.toString());
  //   } catch (e) {
  //     _logException(e.toString());
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _isLoading = false;
  //     _fileName =
  //     _paths != null ? _paths!.map((e) => e.name).toString() : '...';
  //     _userAborted = _paths == null;
  //   });
  // }



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
          gradient: const LinearGradient(
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
          color: const Color(0xFFE063FF),
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

            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const Gallery()),
            );
          },
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
          color: const Color(0xFF28B6ED),
          // gradient: LinearGradient(
          //   colors: <Color>[
          //     Color(0xFFE600EB),
          //     Color(0xFF1ABEFF),
          //   ],
          // ),
        ),
        child: MaterialButton(
          onPressed: () async {
            Navigator.of(context).pop();

            Navigator.push(context, MaterialPageRoute(builder: (context)=> AllSongs()));

            // FilePickerResult? audioFile = await FilePicker.platform.pickFiles(type: FileType.audio);
            //
            // if (audioFile != null) {
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> AudioEditor(audioFile: , )));
            //   // File file = File(audioPath.path);
            // } else {
            //   // User canceled the picker
            // }


            // final path =
            //     await FilePicker.getFilePath(type: FileType.AUDIO );
            // // if (audio != null) {
            // //   Navigator.of(context).push(
            // //     MaterialPageRoute(
            // //       builder: (context) => AudioEditor(
            // //         audioFile: File(audio.path),
            // //         audioPath:  audio.path,
            // //       ),
            // //     ),
            // //   );
            // // }
            // setState(() {
            //   isPlaying = true;
            // });
            // playAudioFromLocalStorage(path);
            // setAudio();
            // final audio = await FilePicker.platform.pickFiles(
            //   type: FileType.custom,
            //
            //   onFileLoading: (FilePickerStatus status) => print(status),
            //   allowedExtensions: ['mp3'],
            //   allowMultiple: true,
            // );
            // if (audio != null) {
            //   final file = File(result.files.s)
            //   print('hi');
            //   mp3 = audio.files.first;
            //   print('this path = $mp3');
            //
            //   // setState(() {
            //   //   audioFile = mp3 ;
            //   // });
            //   // openFile(file);
            //   // Navigator.push(
            //   //   context,
            //   //   MaterialPageRoute(
            //   //     builder: (context)=> AudioEditor(audioFile:  File(audioFile!.path),
            //   //     ),
            //   //   ),
            //   // );
            // }



          },
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
          gradient: const LinearGradient(
            colors: <Color>[
              Color(0xFFE063FF),
              Color(0xFF5DB2EF),
            ],
          ),
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
      transitionDuration: const Duration(milliseconds: 700),
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
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(18)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
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


  Future<void>_loadResources(bool reload) async{
    setState(() {

    });
    // await Get.find<ProductController>().getReco
  }

  @override
  Widget build(BuildContext context) {
    // PlatformFile mp3;
    // final File fileForFirebase = File(mp3.path);
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: GradientText(
            "Concept",
            style: GoogleFonts.rumRaisin(
              fontWeight: FontWeight.w500,
              fontSize: 28,
            ),
            colors: const <Color>[
              Color(0xFF3E6372),
              Color(0xFF362345),
            ],
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                showCustomDialog(context);
              },
              icon: GradientIcon(
                Icons.add_circle_outline_sharp,
                30,
                const LinearGradient(
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
        body: RefreshIndicator(
          color: Colors.purpleAccent,
          onRefresh: () async{
           await _loadResources(true);
          },
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy("datePublished", descending: true)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0XFF28B6ED),
                    backgroundColor: Color(0XFFFA0AFF),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width > webScreenSize ? width * 0.3 : 0,
                    vertical: width > webScreenSize ? 15 : 0,
                  ),
                  child: PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
