import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';
import '../../layouts/mobile_screen_layout.dart';
import '../../model/post.dart';
import '../../resources/storage_methods.dart';
import '../../widget/global_variables.dart';
import '../../widget/utils.dart';

class Video_Confirm_Screen extends StatefulWidget {
  const Video_Confirm_Screen({Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  final Future<File?> videoFile;
  final String videoPath;


  @override
  State<Video_Confirm_Screen> createState() => Video_Confirm_ScreenState();
}

class Video_Confirm_ScreenState extends State<Video_Confirm_Screen> {
  int im = 0;



  String photoUrl = "",
      userName = "",
      description = "",
      time = "",
      user_id = "",
      profImage = "",
      songName = "",
      caption = "",
      videoUrl = "",
      videoPath = "",
      isPhoto = "";



  bool isLoading = false;

  bool initialized = false;

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;

  final TextEditingController _captionController = TextEditingController();
  VideoPlayerController? _controller;


  @override
  void dispose() {
    _controller?.dispose();
    _captionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _fetch();
    _initVideo();
    super.initState();
  }

  _initVideo() async {
    final video = await widget.videoFile;
    setState(() {
      videoPath = widget.videoPath;
    });
    _controller = VideoPlayerController.file(video!)
    // Play the video again when it ends
      ..setLooping(true)
    // initialize the controller and notify UI when done
      ..initialize().then((_) => setState(() => initialized = true));
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

  uploadVideo( String caption , String videoPath) async {
    setState(() {
      isLoading = true;
    });

    String res = "Some error";

    try {
      String docId = FirebaseFirestore.instance.collection('posts').doc().id;

      String videoUrl =
      await StorageMethods().uploadVideoToStorage("post", videoPath , true).catchError((e){
        Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_SHORT);
      });

      Post post = Post(
        uid: user_id,
        username: userName,
        likes: [],
        postId: docId,
        datePublished: DateTime.now(),
        postUrl: profImage,
        profImage: photoUrl,
        id: "",
        songName: songName,
        caption: _captionController.text,
        isPhoto: isPhoto == "true" ? true : false,
        videoUrl: videoUrl,
      );

      await firestore.collection('posts').doc(docId).set(
        post.toJson(),
      );
      firestore
          .collection('users')
          .doc(user_id)
          .collection("MyPosts")
          .doc(docId)
          .set(post.toJson());
      if (res == "Success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted! :)',
        );
        //clearVideo();
      } else {
        showSnackBar(context, res);
      }

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
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
                              color: const Color(0xFF000000),
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
                              border: InputBorder.none,),
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
                              alignment: Alignment.center,
                              child: Center(
                                  child: AspectRatio(
                                    aspectRatio: _controller!.value.aspectRatio,
                                    child: VideoPlayer(_controller!),
                                  ),
                              ),
                            ),
                            Center(
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
                                  color: Color(0xFFFFFFFF).withOpacity(0.75),size: 30,),
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
                          onPressed: () {

                            uploadVideo(_captionController.text, widget.videoPath).whenComplete(
                                  () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => MobileScreenLayout(),
                                ),
                              ),
                            );
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
