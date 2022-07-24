import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../layouts/mobile_screen_layout.dart';
import '../../model/post.dart';
import '../../resources/storage_methods.dart';
import '../../widget/utils.dart';

class ImageConfirmScreen extends StatefulWidget {
  const ImageConfirmScreen({Key? key, required this.imageFile, required this.image, required this.croppedImg})
      : super(key: key);

  final Future<File?> imageFile;
  final File image;
  final bool croppedImg;

  @override
  State<ImageConfirmScreen> createState() => _ImageConfirmScreenState();
}

class _ImageConfirmScreenState extends State<ImageConfirmScreen> {
  int im = 0;


  @override
  void initState() {
    _fetch();
    super.initState();
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
      isPhoto = "";

  late File imgFile;


  Uint8List? _file;

  bool isLoading = false;

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;

  final TextEditingController _captionController = TextEditingController();

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

  Future<String> uploadImage() async {
    setState(() {
      isLoading = true;
    });

    String res = "Some error";

    try {
      String docId = FirebaseFirestore.instance.collection('posts').doc().id;
      print({'yourid ${docId} '});

      String profImage =
      await StorageMethods().uploadImageToStorage('posts', _file!, true);

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

      FirebaseFirestore.instance
          .collection('posts')
          .doc(docId)
          .set(post.toJson());

      FirebaseFirestore.instance
          .collection('users')
          .doc(user_id)
          .collection("MyPosts")
          .doc(docId)
          .set(post.toJson());
      res = "Success";

      if (res == "Success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted! :)',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (e) {
      res = e.toString();
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return res;
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _captionController.dispose();
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
                              border: InputBorder.none),
                          maxLines: 5,
                        ),
                      ),
                          // widget.croppedImg
                         // ? Container(
                         //   height: 120.0,
                         //   width: 80.0,
                         //   child: AspectRatio(
                         //   aspectRatio: 487 / 451,
                         //   child: Container(
                         //   height: 350,
                         //   decoration: BoxDecoration(
                         //   borderRadius: BorderRadius.circular(8.0)),
                         //   alignment: Alignment.center,
                         //   child:/* widget.image != null*/
                         //      Image.file(widget.image),
                         //   ),
                         //   ),
                         //  )
                      Container(
                        height: 120.0,
                        width: 80.0,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            height: 350,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0)),
                            alignment: Alignment.center,
                            child:widget.image!=null
                                ?Image.file(widget.image)
                                :FutureBuilder<File?>(
                                 future: widget.imageFile, //assets[im].file,
                              builder: (_, snapshot) {
                                final file = snapshot.data;
                                imgFile = file!;
                                if (file == null) return Container();
                                return Image.file(imgFile);
                              },
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
                        width: 5 * (MediaQuery.of(context).size.width / 17),
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
                          onPressed: () async {
                            setState(() {
                              imgFile = widget.image;
                            });
                            Uint8List imageRaw = await imgFile.readAsBytes();
                            setState(() {
                              isPhoto = "true";
                              _file = imageRaw;
                              print('this path = $_file');
                            });
                            Uint8List imgRaw = await imgFile.readAsBytes();
                            setState(() {
                              isPhoto = "true";
                              _file = imgRaw;
                              print('this path = $_file');
                            });
                            uploadImage().whenComplete(
                                  () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const MobileScreenLayout(),
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
