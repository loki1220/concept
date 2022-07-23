import 'dart:io';
import 'dart:typed_data';
import 'package:concept/screens/uploading_screens/image_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import '../../widget/filters_color.dart';

class ImageFilterPage extends StatefulWidget {
  const ImageFilterPage({Key? key, required this.imageFile, required this.image, required this.croppedImg})
      : super(key: key);


  final Future<File?> imageFile;
  final File image;
  final bool croppedImg;

  @override
  _ImageFilterPageState createState() => _ImageFilterPageState();
}

class _ImageFilterPageState extends State<ImageFilterPage> {
  final GlobalKey _globalKey = GlobalKey();
  final List<List<double>> filters = [SEPIA_MATRIX, GREYSCALE_MATRIX , VINTAGE_MATRIX, SWEET_MATRIX];

  // void convertWidgetToImage() async {
  //   RenderRepaintBoundary repaintBoundary = _globalKey.currentContext.findRenderObject();
  //   ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
  //   ByteData byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List uint8list = byteData.buffer.asUint8List();
  //   Navigator.of(_globalKey.currentContext).push(MaterialPageRoute(
  //       builder: (context) => ImageEditor(
  //         imageData: uint8list, imageFile: null,
  //       )));
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Image image = Image.asset(
      "assets/images/sample.png",
      width: size.width,
      fit: BoxFit.cover,
    );
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Image Filters",
      //   ),
      //   backgroundColor: Colors.deepOrange,
      //   actions: [IconButton(icon: Icon(Icons.check), onPressed: convertWidgetToImage)],
      // ),
      backgroundColor: Colors.black,
      body: Center(
        child: RepaintBoundary(
          key: _globalKey,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: size.width,
              maxHeight: size.width,
            ),
            child: PageView.builder(
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return ColorFiltered(
                    colorFilter: ColorFilter.matrix(filters[index]),
                    child: image,
                  );
                }),
          ),
        ),
      ),
    );
  }
}