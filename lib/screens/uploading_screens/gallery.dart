import 'dart:io';
import 'package:concept/screens/uploading_screens/image_editor.dart';
import 'package:concept/screens/uploading_screens/video_editor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';
import '../../layouts/mobile_screen_layout.dart';
import 'dart:typed_data';

class Gallery extends StatefulWidget {
  const Gallery({
    Key? key,

    // this.videoFile,
  }) : super(key: key);

  //final Future<File>? imageFile;
  //final Future<File>? videoFile;

  @override
  GalleryState createState() => GalleryState();
}

class GalleryState extends State<Gallery> {
  VideoPlayerController? _controller;

  //bool initialized = false;

  List<AssetEntity> assets = [];

  // Future<File?>? videoFile;

  _fetchAssets() async {
    // Set onlyAll to true, to fetch only the 'Recent' album
    // which contains all the photos/videos in the storage
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    // Now that we got the album, fetch all the assets it contains
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1000000,
      // end at a very big index (to get all the assets)
    );

    // Update the state and notify UI
    setState(() => assets = recentAssets);
  }

  @override
  void initState() {
    _fetchAssets();
   // _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _initVideo() async {
    final video = await assets[im].file;
    print("loki this is video ${video}");
    setState(() {
      _controller =video!=null? VideoPlayerController.file(video):null
      // Play the video again when it ends
          ?.setLooping(true)
      // initialize the controller and notify UI when done
        ..initialize().then((_) => setState(() {}));
    });

  }

  int im = 0;

  bool galleryVideo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                            builder: (_) {
                              if (assets[im].type ==  AssetType.image) {
                                return Image_Editor(imageFile: assets[im].file);
                              }else {
                                return Video_Editor(videoFile: assets[im].file);
                              }
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
          galleryVideo
          // initialized
              ? Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: _controller != null
                              ? VideoPlayer(_controller!)
                              : Container(
                                  child: Text("loki"),
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
                      child: Center(
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
                          color: Color(0xFFFFFFFF).withOpacity(0.75),size: 70,),
                        ),
                      ),
                    )
                  ],
                )
              : Container(
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
                ),/*: Center(child: CircularProgressIndicator(),),*/
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Recents",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF000000),
                ),
              ),
              Icon(
                Icons.photo_library_outlined,
                size: 24,
                color: Color(0xFF000000),
              ),
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
                          if (assets[index].type == AssetType.video) {
                            setState(() {
                              galleryVideo = true;
                              _initVideo();
                              im = index;
                            });
                            setState(() {

                            });
                          }
                          if (assets[index].type == AssetType.image) {
                            setState(() {
                              galleryVideo = false;
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
