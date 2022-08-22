import 'dart:io';
import 'package:concept/screens/uploading_screens/gallery.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor/image_editor.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:simple_gradient_text/simple_gradient_text.dart';

class EditPhotoScreen extends StatefulWidget {
  const EditPhotoScreen({Key? key, this.imageFile, this.imageData});
  final Future<File?>? imageFile;
  final Uint8List? imageData;
  @override
  _EditPhotoScreenState createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
  GlobalKey<ExtendedImageEditorState>();

  double sat = 1;
  double bright = 0;
  double con = 1;
  var imagePath;
  var editImg;

  final defaultColorMatrix = const <double>[
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0
  ];
  List<double> calculateSaturationMatrix(double saturation) {
    final m = List<double>.from(defaultColorMatrix);
    final invSat = 1 - saturation;
    final R = 0.213 * invSat;
    final G = 0.715 * invSat;
    final B = 0.072 * invSat;

    m[0] = R + saturation;
    m[1] = G;
    m[2] = B;
    m[5] = R;
    m[6] = G + saturation;
    m[7] = B;
    m[10] = R;
    m[11] = G;
    m[12] = B + saturation;

    return m;
  }

  List<double> calculateContrastMatrix(double contrast) {
    final m = List<double>.from(defaultColorMatrix);
    m[0] = contrast;
    m[6] = contrast;
    m[12] = contrast;
    return m;
  }



  File? image;
  @override
  void initState() {
    super.initState();
   image = editImg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF28B6ED),),
        ),
          title: GradientText(
            "Edit Image",
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings_backup_restore, color: Color(0xFF5DB2EF),),
              onPressed: () {
                setState(() {
                  sat = 1;
                  bright = 0;
                  con = 1;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.check,color: Color(0xFFFA0AFF),),
              onPressed: () async {
                await crop();
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: AspectRatio(
                  aspectRatio: 1,
                  // child: buildImage(),
                  child: FutureBuilder<File?>(
                    future: widget.imageFile, //assets[im].file,
                    builder: (_, snapshot) {
                      final editImg = snapshot.data;
                      imagePath=snapshot.data;
                      if (editImg == null) return Container();
                      return Image.file(editImg);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: SliderTheme(
                  data: const SliderThemeData(
                    showValueIndicator: ShowValueIndicator.never,
                  ),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(flex: 3),
                        _buildSat(),
                        Spacer(flex: 1),
                        _buildBrightness(),
                        Spacer(flex: 1),
                        _buildCon(),
                        Spacer(flex: 3),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildFunctions(),
    );
  }

  Widget buildImage() {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(calculateContrastMatrix(con)),
      child: ColorFiltered(
        colorFilter: ColorFilter.matrix(calculateSaturationMatrix(sat)),
        child: ExtendedImage(
          color: bright > 0
              ? Colors.white.withOpacity(bright)
              : Colors.black.withOpacity(-bright),
          colorBlendMode: bright > 0 ? BlendMode.lighten : BlendMode.darken,
          image: ExtendedFileImageProvider(editImg),
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          extendedImageEditorKey: editorKey,
          mode: ExtendedImageMode.editor,
          fit: BoxFit.contain,
          initEditorConfigHandler: (ExtendedImageState? state) {
            return EditorConfig(
              maxScale: 8.0,
              cropRectPadding: const EdgeInsets.all(20.0),
              hitTestSize: 20.0,
            );
          },
        ),
      ),
    );
  }

  Widget _buildFunctions() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.flip,
            color: Colors.black,
          ),
          label:  'Flip',
          backgroundColor: Colors.red
          // Text(
          //   'Flip',
          //   style: TextStyle(
          //     color: Colors.white,
          //   ),
          // ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.rotate_left,
            color: Colors.black,
          ),
          label: 'Rotate left',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.rotate_right,
            color: Colors.black,
          ),
          label: 'Rotate right',
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            flip();
            break;
          case 1:
            rotate(false);
            break;
          case 2:
            rotate(true);
            break;
        }
      },
      currentIndex: 0,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).primaryColor,
    );
  }

  Future<void> crop([bool test = false]) async {
    final ExtendedImageEditorState? state = editorKey.currentState;
    final Rect? rect = state?.getCropRect();
    final EditActionDetails? action = state?.editAction;
    final double? radian = action?.rotateAngle;

    final bool flipHorizontal = action!.flipY;
    final bool flipVertical = action.flipX;
    final Uint8List? img = state?.rawImageData;

    final ImageEditorOption option = ImageEditorOption();

    option.addOption(ClipOption.fromRect(rect!));
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
    if (action.hasRotateAngle) {
      option.addOption(RotateOption(radian!.toInt()));
    }

    option.addOption(ColorOption.saturation(sat));
    option.addOption(ColorOption.brightness(bright + 1));
    option.addOption(ColorOption.contrast(con));

    option.outputFormat = const OutputFormat.jpeg(100);

    print(const JsonEncoder.withIndent('  ').convert(option.toJson()));

    final DateTime start = DateTime.now();
    final Uint8List? result = await ImageEditor.editImage(
      image: img!,
      imageEditorOption: option,
    );

    print('result.length = ${result?.length}');

    final Duration diff = DateTime.now().difference(start);
    image?.writeAsBytesSync(result!);
    print('image_editor time : $diff');
    Future.delayed(Duration(seconds: 0)).then(
          (value) => Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => Gallery(),
        ),
      ),
    );
  }

  void flip() {
    editorKey.currentState?.flip();
  }

  void rotate(bool right) {
    editorKey.currentState?.rotate(right: right);
  }

  Widget _buildSat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.brush,
              color: Colors.black,
            ),
            Text(
              "Saturation",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            label: 'sat : ${sat.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                sat = value;
              });
            },
            divisions: 50,
            value: sat,
            min: 0,
            max: 2,
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(sat.toStringAsFixed(2)),
        ),
      ],
    );
  }

  Widget _buildBrightness() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: <Widget>[
            Icon(
              Icons.brightness_4,
              color: Colors.black,
            ),
            Text(
              "Brightness",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            label: '${bright.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                bright = value;
              });
            },
            divisions: 50,
            value: bright,
            min: -1,
            max: 1,
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(bright.toStringAsFixed(2)),
        ),
      ],
    );
  }

  Widget _buildCon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: <Widget>[
            Icon(
              Icons.color_lens,
              color: Colors.black,
            ),
            Text(
              "Contrast",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            label: 'con : ${con.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                con = value;
              });
            },
            divisions: 50,
            value: con,
            min: 0,
            max: 4,
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(con.toStringAsFixed(2)),
        ),
      ],
    );
  }
}






// import 'dart:io';
// import 'dart:typed_data';
// import 'package:concept/screens/uploading_screens/image_editor.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/rendering.dart';
// import 'dart:ui' as ui;
//
// import '../../widget/filters_color.dart';
//
// class ImageFilterPage extends StatefulWidget {
//   const ImageFilterPage({Key? key, required this.imageFile, required this.image, required this.croppedImg})
//       : super(key: key);
//
//
//   final Future<File?> imageFile;
//   final File image;
//   final bool croppedImg;
//
//   @override
//   _ImageFilterPageState createState() => _ImageFilterPageState();
// }
//
// class _ImageFilterPageState extends State<ImageFilterPage> {
//   final GlobalKey _globalKey = GlobalKey();
//   final List<List<double>> filters = [SEPIA_MATRIX, GREYSCALE_MATRIX , VINTAGE_MATRIX, SWEET_MATRIX];
//
//   // void convertWidgetToImage() async {
//   //   RenderRepaintBoundary repaintBoundary = _globalKey.currentContext.findRenderObject();
//   //   ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
//   //   ByteData byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
//   //   Uint8List uint8list = byteData.buffer.asUint8List();
//   //   Navigator.of(_globalKey.currentContext).push(MaterialPageRoute(
//   //       builder: (context) => ImageEditor(
//   //         imageData: uint8list, imageFile: null,
//   //       )));
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final Image image = Image.asset(
//       "assets/loki.jpg",
//       width: size.width,
//       fit: BoxFit.cover,
//     );
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(
//       //     "Image Filters",
//       //   ),
//       //   backgroundColor: Colors.deepOrange,
//       //   actions: [IconButton(icon: Icon(Icons.check), onPressed: convertWidgetToImage)],
//       // ),
//       backgroundColor: Colors.black,
//       body: Center(
//         child: RepaintBoundary(
//           key: _globalKey,
//           child: Container(
//             constraints: BoxConstraints(
//               maxWidth: size.width,
//               maxHeight: size.width,
//             ),
//             child: PageView.builder(
//                 itemCount: filters.length,
//                 itemBuilder: (context, index) {
//                   return ColorFiltered(
//                     colorFilter: ColorFilter.matrix(filters[index]),
//                     child: image,
//                   );
//                 }),
//           ),
//         ),
//       ),
//     );
//   }
// }