import 'dart:io';
import 'dart:typed_data';
import 'package:concept/screens/uploading_screens/gallery.dart';
import 'package:concept/screens/uploading_screens/image_filter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'image_confirm.dart';

class ImageEditorScreen extends StatefulWidget {
  const ImageEditorScreen({Key? key, required this.imageFile, this.imageData}) : super(key: key);

   final Future<File?> imageFile;
  final Uint8List? imageData;



  @override
  State<ImageEditorScreen> createState() => _ImageEditorScreenState();
}

class _ImageEditorScreenState extends State<ImageEditorScreen> {
  // static List<AssetEntity> assets = [];
  int im = 0;
  final picker = ImagePicker();
  List<File> imageFiles = [];

  var imagePath;

  var image;


  // String? imagePath;
  // Uint8List? imgFile;
  // late File imgFile;

  // Uint8List? _file;


  // final Future<File?> imageFile;


  // @override
  // void initState() {
  //   // _fetch();
  //   // Uint8List img =  imgFile.readAsBytes();
  //   // setState(() {
  //   //   imagePath = widget.imagePath;
  //   //   img = ;
  //   // });
  //   // super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
        children: <Widget>[
        const SizedBox(
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
                        MaterialPageRoute(builder: (builder) => const Gallery()));
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
                        builder: (context) => ImageConfirmScreen(
                          imageFile: widget.imageFile,
                          image: image!= null ?image :imagePath, croppedImg: false,
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
          child:
          Container(
            height: 350,
            // color: Colors.black,
            alignment: Alignment.center,
            child: image!=null
                ?Image.file(image)
                :FutureBuilder<File?>(
                  future: widget.imageFile, //assets[im].file,
                  builder: (_, snapshot) {
                  final file = snapshot.data;
                  imagePath=snapshot.data;
                   if (file == null) return Container();
                   return Image.file(file);
              },
            ),
          ),
          // Container(
          //   height: 350,
          //   decoration: BoxDecoration(
          //     // shape: BoxShape.rectangle,
          //     color: Colors.black,
          //     image: DecorationImage(
          //       fit: BoxFit.fill,
          //       image: AssetImage("assets/editing.png"),
          //     ),
          //   ),
          // ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                cropImage();
              },
              icon: Icon(
                Icons.crop_rotate,
                size: 24,
                color: Color(0xFF575757),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPhotoScreen(
                      imageFile: widget.imageFile,
                    ),
                  ),
                );
              },
              icon: Icon(
                // Icons.exposure_outlined,
                Icons.edit_outlined,
                size: 24,
                color: Color(0xFF575757),
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.wb_sunny_outlined,
            //     size: 24,
            //     color: Color(0xFF575757),
            //   ),
            // ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.brightness_6_sharp,
            //     size: 24,
            //     color: Color(0xFF575757),
            //   ),
            // ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     TextButton(
        //       onPressed: () {},
        //       style: ElevatedButton.styleFrom(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: 25,
        //         ),
        //       ),
        //       child: Text(
        //         "Cancel",
        //         textAlign: TextAlign.center,
        //         style: GoogleFonts.roboto(
        //             fontSize: 20,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xFF393939)),
        //       ),
        //     ),
        //     TextButton(
        //       onPressed: () {},
        //       style: ElevatedButton.styleFrom(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: 25,
        //         ),
        //       ),
        //       child: Text(
        //         "Done",
        //         textAlign: TextAlign.center,
        //         style: GoogleFonts.roboto(
        //             fontSize: 20,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xFFFA0AFF)),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    ),
    );
  }

cropImage()async{
  File? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
         CropAspectRatioPreset.square,
      ]
          : [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        title: 'Cropper',
      ));
  if (croppedFile != null) {
    setState(() {
      image = croppedFile;

      //_imageList.add(croppedFile);


      // uploadPic(imageFile!);
    });
  }
}
}
