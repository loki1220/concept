import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concept/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path/path.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../layouts/mobile_screen_layout.dart';
import '../../model/post.dart';
import '../../resources/firebase_api.dart';
import '../../widget/global_variables.dart';
import '../../widget/utils.dart';

class AudioConfirmScreen extends StatefulWidget {
  const AudioConfirmScreen({Key? key,  required this.songModel, required this.audioPlayer}) : super(key: key);

  final SongModel songModel;
  final AudioPlayer audioPlayer;

  @override
  State<AudioConfirmScreen> createState() => _AudioConfirmScreenState();
}

class _AudioConfirmScreenState extends State<AudioConfirmScreen> {

  bool _isLoading = false;

  bool _isPlaying = false;

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;


  UploadTask? task;
  File? file;

  Duration _duration = const Duration();
  Duration _position = const Duration();

  final TextEditingController _captionController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetch();
    playSong();
  }

  String photoUrl = "",
      userName = "",
      description = "",
      time = "",
      user_id = "",
      profImage = "",
      songName = "",
      caption = "",
      videoUrl = "",
      audioUrl = "",
      audioPath = "",
      videoPath = "",
      isPhoto = "";


  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );


  // uploadAudio( String caption , String audioPath) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   String res = "Some error";
  //
  //   try {
  //     String docId = FirebaseFirestore.instance.collection('posts').doc().id;
  //
  //     String audioUrl =
  //     await StorageMethods().uploadAudioToStorage("post", audioPath , true).catchError((e){
  //       Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_SHORT);
  //     });
  //
  //     Post post = Post(
  //       uid: user_id,
  //       username: userName,
  //       likes: [],
  //       postId: docId,
  //       datePublished: DateTime.now(),
  //       postUrl: profImage,
  //       profImage: photoUrl,
  //       id: "",
  //       songName: songName,
  //       caption: _captionController.text,
  //       isPhoto: isPhoto == "true" ? true : false,
  //       videoUrl: videoUrl,
  //       audioUrl: audioUrl,
  //     );
  //
  //     await firestore.collection('posts').doc(docId).set(
  //       post.toJson(),
  //     );
  //     firestore
  //         .collection('users')
  //         .doc(user_id)
  //         .collection("MyPosts")
  //         .doc(docId)
  //         .set(post.toJson());
  //     if (res == "Success") {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       showSnackBar(
  //         context,
  //         'Posted! :)',
  //       );
  //       //clearVideo();
  //     } else {
  //       showSnackBar(context, res);
  //     }
  //
  //     Get.back();
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error Uploading Video',
  //       e.toString(),
  //     );
  //   }
  // }




  // uploadAudio( String caption , String videoPath) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   String res = "Some error";
  //
  //   try {
  //     String docId = FirebaseFirestore.instance.collection('posts').doc().id;
  //
  //     String audioUrl =
  //     await StorageMethods().uploadVideoToStorage("post", videoPath , true).catchError((e){
  //       Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_SHORT);
  //     });
  //
  //     Post post = Post(
  //       uid: user_id,
  //       username: userName,
  //       likes: [],
  //       postId: docId,
  //       datePublished: DateTime.now(),
  //       postUrl: profImage,
  //       profImage: photoUrl,
  //       id: "",
  //       songName: songName,
  //       caption: _captionController.text,
  //       isPhoto: isPhoto == "true" ? true : false,
  //       videoUrl: videoUrl,
  //       audioUrl: audioUrl,
  //     );
  //
  //     await firestore.collection('posts').doc(docId).set(
  //       post.toJson(),
  //     );
  //     firestore
  //         .collection('users')
  //         .doc(user_id)
  //         .collection("MyPosts")
  //         .doc(docId)
  //         .set(post.toJson());
  //     if (res == "Success") {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       showSnackBar(
  //         context,
  //         'Posted! :)',
  //       );
  //       //clearVideo();
  //     } else {
  //       showSnackBar(context, res);
  //     }
  //
  //     Get.back();
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error Uploading Audio',
  //       e.toString(),
  //     );
  //   }
  // }


  // Future<String> uploadAudio() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   String res = "Some error";
  //
  //   try{
  //     String docId = FirebaseFirestore.instance.collection('posts').doc().id;
  //     print({'yourid ${docId} '});
  //
  //     String profImage =
  //     await StorageMethods().uploadAudioToStorage('posts', audioPath, true);
  //   }
  //
  //   // if (file == null)  return;
  //
  //   final fileName = basename(file!.path);
  //   final destination = 'files/$fileName';
  //
  //   task = StorageMethods.uploadAudioToStorage('posts', audioPath, true);
  //   setState(() {});
  //
  //   if (task == null) return (Container());
  //
  //   final snapshot = await task!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //
  //   print('Download-Link: $urlDownload');
  // }





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



  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) async {
        setState(() {
          photoUrl = ds.data()!["photoUrl"];
          userName = ds.data()!["username"];
          user_id = ds.data()!["uid"];

          Fluttertoast.showToast(msg: userName);
        });
      }).catchError((e) {
        print(e);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    // final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight - 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                colors: [
                                  Color(0xFF5DB2EF),
                                  Color(0xFFFA0AFF)],
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
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _isLoading
                ? const LinearProgressIndicator()
                : const Padding(padding: EdgeInsets.only(top: 0.0)),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 2,
              child: Container(
                decoration: const BoxDecoration(
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
                      if (photoUrl != "")
                        CircleAvatar(backgroundImage: NetworkImage(photoUrl)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFormField(
                          controller: _captionController,
                          decoration: const InputDecoration(
                              hintText: "Write a caption...",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9E9E9E),
                              ),
                              border: InputBorder.none
                          ),
                              maxLines: 5,
                        ),
                      ),
                      Container(
                        height: 90.0,
                        width: 80.0,
                        child: Stack(
                          children: [
                            Container(
                              height: 350,
                              // color: Colors.black,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black,
                              ),
                              // alignment: Alignment.center,
                              child:   Center(
                                child: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      if(_isPlaying){
                                        widget.audioPlayer.pause();
                                      }else{
                                        widget.audioPlayer.play();
                                      }
                                      _isPlaying = !_isPlaying;

                                    });
                                  },
                                  icon: Icon(
                                    _isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: Color(0xFF515151),
                                  ),
                                ),
                                  // aspectRatio: _controller!.value.aspectRatio,
                                  // child: VideoPlayer(_controller!),
                                ),
                              ),

                          ],
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
                  const Divider(),
                  Container(
                    color: const Color(0xFFC4C4C4).withOpacity(0.2),
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
                                    const WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0
                                        ),
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
                              // 9043349676 amiya
                              //   value: true,
                              //   type: GFToggleType.ios,
                              // )
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
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
                                    const WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
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
                        const Divider(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 42,
                        width: 5 * (
                            MediaQuery.of(context).size.width / 17
                        ),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.elliptical(15, 15),
                              right: Radius.elliptical(15, 15),
                            ),
                          ),
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
                          onPressed: ()  {
                            uploadFile();
                            // setState(() {
                            //   imgFile = widget.image;
                            // });
                            // Uint8List imageRaw = await imgFile.readAsBytes();
                            // setState(() {
                            //   isPhoto = "true";
                            //   _file = imageRaw;
                            //   print('this path = $_file');
                            // });
                            // Uint8List imgRaw = await imgFile.readAsBytes();
                            // setState(() {
                            //   isPhoto = "true";
                            //   _file = imgRaw;
                            //   print('this path = $_file');
                            // });
                            // uploadImage().whenComplete(
                            //       () => Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //       builder: (context) => const MobileScreenLayout(),
                            //     ),
                            //   ),
                            // );
                          },
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
