import 'dart:io';
import 'package:concept/screens/image_editor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../layouts/mobile_screen_layout.dart';
import 'dart:typed_data';

class Gallery extends StatefulWidget {
  const Gallery({
    Key? key,
    // this.imageFile,
  }) : super(key: key);

  //final Future<File?>? imageFile;

  @override
  GalleryState createState() => GalleryState();
}

class GalleryState extends State<Gallery> {
  static List<AssetEntity> assets = [];

  _fetchAssets() async {
    // Set onlyAll to true, to fetch only the 'Recent' album
    // which contains all the photos/videos in the storage
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    // Now that we got the album, fetch all the assets it contains
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1000000, // end at a very big index (to get all the assets)
    );

    // Update the state and notify UI
    setState(() => assets = recentAssets);
  }

  @override
  void initState() {
    _fetchAssets();
    super.initState();
  }

  int im = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Column(
        children: [
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => MobileScreenLayout()));
                    },
                    icon: Icon(Icons.clear),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
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
                            builder: (context) => Image_Editor(
                              imageFile: assets[im].file,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: assets[im].file != null
                ? Container(
                    // color: Colors.black,
                    alignment: Alignment.center,
                    child: FutureBuilder<File?>(
                      future: assets[im].file,
                      builder: (_, snapshot) {
                        final file = snapshot.data;
                        if (file == null) return Container();
                        return Image.file(file);
                      },
                    ),
                  )
                : Container(
                    child: GradientText(
                      "Select Photo",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400, fontSize: 25),
                      colors: [
                        Color(0xFF5DB2EF),
                        Color(0xFFFA0AFF),
                      ],
                    ),
                  ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                "Recents",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF000000),
                ),
              ),
              Icon(Icons.photo_library_sharp),
            ],
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 3.0,
              child: GridView.builder(
                //scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // A grid view with 3 items per row
                  crossAxisCount: 3,
                ),
                itemCount: assets.length,
                itemBuilder: (_, index) {
                  return FutureBuilder<Uint8List?>(
                    future: assets[index].thumbnailData,
                    builder: (_, snapshot) {
                      final bytes = snapshot.data;
                      // If we have no data, display a spinner
                      if (bytes == null) return CircularProgressIndicator();
                      // If there's data, display it as an image
                      return InkWell(
                        onTap: () {
                          if (assets[index].type == AssetType.image) {
                            setState(() {
                              im = index;
                            });
                          }
                        },
                        child: Stack(
                          children: [
                            // Wrap the image in a Positioned.fill to fill the space
                            Positioned.fill(
                              child: Image.memory(bytes, fit: BoxFit.cover),
                            ),
                            // Display a Play icon if the asset is a video
                            if (assets[index].type == AssetType.video)
                              Center(
                                child: Container(
                                  color: Colors.blue,
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
