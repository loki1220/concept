import 'dart:io';
import 'dart:typed_data';
import 'package:concept/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'file.dart';

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final AssetEntity? asset;

  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List?>(
      future: asset?.thumbnailData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null) {
          return CircularProgressIndicator();
        }
        // If there's data, display it as an image
        return InkWell(
            onTap: () {
              Fluttertoast.showToast(
                  msg: asset!.id.toString(), toastLength: Toast.LENGTH_SHORT);
              print(asset!.toString());
            },
            /*Image.memory(bytes, fit: BoxFit.cover);*/
            child: Stack(children: [
              // Wrap the image in a Positioned.fill to fill the space
              Positioned.fill(
                child: Image.memory(bytes, fit: BoxFit.cover),
              ),
              // Display a Play icon if the asset is a video
              if (asset?.type == AssetType.video)
                Center(
                  child: Container(
                    color: Colors.blue,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
            ]));
      },
    );
  }
}

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<AssetEntity> assets = [];

  Future<File>? imageFile;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => FeedScreen()));
                        },
                        icon: Icon(Icons.clear),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        GradientText(
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
                        )
                      ],
                    ),
                  )
                ],
              ),
              Divider(),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   //color: Colors.black,
              //   alignment: Alignment.center,
              //   child: FutureBuilder<File>(
              //     future: imageFile,
              //     builder: (_, snapshot) {
              //       final file = snapshot.data;
              //       if (file == null) return Container();
              //       return Image.file(file);
              //     },
              //   ),
              // ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: assets != null
                      ? Image.file(File("assets.indexOf(imageFile.)"),
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: MediaQuery.of(context).size.width)
                      : Container(
                          child: Text("No data"),
                        )),
              Divider(),
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
                      return AssetThumbnail(asset: assets[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
