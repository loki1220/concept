import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
   late VideoPlayerController videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   videoPlayerController = VideoPlayerController.network(widget.videoUrl)..setLooping(true)
  //     ..initialize().then((value) {
  //       videoPlayerController.play();
  //       videoPlayerController.setVolume(1);
  //     });
  // }

   // @override
   // void initState() {
   //   videoPlayerController = VideoPlayerController.network(
   //       widget.videoUrl);
   //   _initializeVideoPlayerFuture = videoPlayerController.initialize();
   //   videoPlayerController.setLooping(true);
   //   videoPlayerController.setVolume(1.0);
   //   super.initState();
   // }

   @override
   void initState() {
     videoPlayerController = VideoPlayerController.network(widget.videoUrl)
         ..addListener(() =>setState(() {}))
         ..setLooping(true)
         ..initialize().then((value) => videoPlayerController.play());
   }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // return Stack(
    //   children: [
    //     Container(
    //       width: size.width,
    //       height: size.height,
    //       decoration: const BoxDecoration(
    //         color: Colors.black,
    //       ),
    //       child: FutureBuilder(
    //         future: _initializeVideoPlayerFuture,
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.done) {
    //             return AspectRatio(
    //               aspectRatio: videoPlayerController.value.aspectRatio,
    //               child: VideoPlayer(videoPlayerController),
    //             );
    //           }
    //           else {
    //             return
    //               const Center(
    //               child: CircularProgressIndicator(backgroundColor: Colors.orange,
    //               ),
    //             );
    //           }
    //       }
    //       ),
    //     ),
    //     Center(
    //       child: IconButton(
    //         onPressed: (){
    //           setState(() {
    //             // If the video is playing, pause it.
    //             if (videoPlayerController.value.isPlaying) {
    //               videoPlayerController.pause();
    //             } else {
    //               // If the video is paused, play it.
    //               videoPlayerController.play();
    //             }
    //           });
    //         },
    //         icon: Icon(
    //           videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //           color: const Color(0xFFFFFFFF),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoPlayerController),
    );

  }
}



//
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerItem extends StatefulWidget {
//   final String videoUrl;
//   const VideoPlayerItem({
//     Key? key,
//     required this.videoUrl,
//   }) : super(key: key);
//
//   @override
//   _VideoPlayerItemState createState() => _VideoPlayerItemState();
// }
//
// class _VideoPlayerItemState extends State<VideoPlayerItem> {
//    VideoPlayerController? videoPlayerController;
//
//
//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController = VideoPlayerController.network(widget.videoUrl)..setLooping(true)
//       ..initialize().then((_) =>
//
//         // videoPlayerController!.play()
//         // videoPlayerController!.setVolume(1),
//         setState(() {})
//       );
//   }
//
//   // @override
//   // void initState() {
//   //   // // Create and store the VideoPlayerController. The VideoPlayerController
//   //   // // offers several different constructors to play videos from assets, files,
//   //   // // or the internet.
//   //   // videoPlayerController = VideoPlayerController.network(
//   //   //   widget.videoUrl
//   //   // );
//   //   //
//   //   // // Initialize the controller and store the Future for later use.
//   //   // _initializeVideoPlayerFuture = videoPlayerController!.initialize();
//   //   //
//   //   // // Use the controller to loop the video.
//   //   // videoPlayerController!.setLooping(true);
//   //   //
//   //   // super.initState();
//   // }
//
//    // _initVideo() async {
//    //   final video = await widget.videoUrl;
//    //
//    //   videoPlayerController = VideoPlayerController.network(video)
//    //   // Play the video again when it ends
//    //     ..setLooping(true)
//    //
//    //   // initialize the controller and notify UI when done
//    //     ..initialize().then((_) => setState(() {}));
//    // }
//
//
//    @override
//   void dispose() {
//      videoPlayerController?.dispose();
//      super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return  Container(
//       height: 350,
//       child: Center(
//         child: AspectRatio(
//           aspectRatio: videoPlayerController!.value.aspectRatio,
//           child: VideoPlayer(videoPlayerController!),
//         ),
//       ),
//
//     child: Padding(
//     padding: const EdgeInsets.symmetric(vertical: 100,),
//     child: Center(
//     child: IconButton(
//     onPressed: () {
//     setState(() {
//     if (videoPlayerController!.value.isPlaying) {
//     videoPlayerController!.pause();
//     } else {
//     videoPlayerController!.play();
//     }
//     });
//     },
//     icon: Icon(
//     videoPlayerController!.value.isPlaying
//     ? Icons.pause
//         : Icons.play_arrow,
//     color: Color(0xFFFFFFFF).withOpacity(0.75),size: 70,),
//     ),
//     ),
//     ),
//     );
//
//
//     // return Container(
//     //   width: size.width,
//     //   height: size.height,
//     //   decoration: const BoxDecoration(
//     //     color: Colors.black,
//     //   ),
//     //   child: Stack(
//     //     children: [
//     //       VideoPlayer(videoPlayerController!),
//     //       Center(
//     //         child: IconButton(
//     //           onPressed: () {
//     //             setState(() {
//     //               if (videoPlayerController!.value.isPlaying) {
//     //                 videoPlayerController!.pause();
//     //               } else {
//     //                 videoPlayerController!.play();
//     //               }
//     //             });
//     //           },
//     //           icon: Icon(
//     //             videoPlayerController!.value.isPlaying
//     //                 ? Icons.pause
//     //                 : Icons.play_arrow,
//     //             color: Colors.black/*(0xFFFFFFFF)*/.withOpacity(0.75),size: 70,),
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//
//
//
//
//
//
//     //   Scaffold(
//     //   body : FutureBuilder(
//     //     builder: (context, snapshot){
//     //       return Stack(
//     //         children: [
//     //           Container(
//     //             width: size.width,
//     //             height: size.height,
//     //             decoration: const BoxDecoration(
//     //               color: Colors.black,
//     //             ),
//     //             child: Stack(
//     //               children: [
//     //                 AspectRatio(
//     //                     aspectRatio: videoPlayerController!.value.aspectRatio,
//     //                     child: VideoPlayer(videoPlayerController!)),
//     //                 Center(
//     //                   child: IconButton(
//     //                     onPressed: () {
//     //                       setState(() {
//     //                         if (videoPlayerController!.value.isPlaying) {
//     //                           videoPlayerController!.pause();
//     //                         } else {
//     //                           videoPlayerController!.play();
//     //                         }
//     //                       });
//     //                     },
//     //                     icon: Icon(
//     //                       videoPlayerController!.value.isPlaying
//     //                           ? Icons.pause
//     //                           : Icons.play_arrow,
//     //                       color: Colors.black/*(0xFFFFFFFF)*/.withOpacity(0.75),size: 70,),
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //           ),
//     //         ],
//     //       );
//     //     },
//     //     // child: Container(
//     //     //   width: size.width,
//     //     //   height: size.height,
//     //     //   decoration: const BoxDecoration(
//     //     //     color: Colors.black,
//     //     //   ),
//     //     //   child: Stack(
//     //     //       children: [
//     //     //         VideoPlayer(videoPlayerController),
//     //     //         Center(
//     //     //           child: IconButton(
//     //     //             onPressed: () {
//     //     //               setState(() {
//     //     //                 if (videoPlayerController.value.isPlaying) {
//     //     //                   videoPlayerController.pause();
//     //     //                 } else {
//     //     //                   videoPlayerController.play();
//     //     //                 }
//     //     //               });
//     //     //             },
//     //     //             icon: Icon(
//     //     //               videoPlayerController.value.isPlaying
//     //     //                   ? Icons.pause
//     //     //                   : Icons.play_arrow,
//     //     //               color: Colors.black/*(0xFFFFFFFF)*/.withOpacity(0.75),size: 70,),
//     //     //           ),
//     //     //         ),
//     //     //       ],
//     //     //   ),
//     //     // ),
//     //   ),
//     // );
//   }
// }
