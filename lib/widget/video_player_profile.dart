import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProfile extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerProfile({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerProfileState createState() => _VideoPlayerProfileState();
}

class _VideoPlayerProfileState extends State<VideoPlayerProfile> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)..setLooping(true)
      ..initialize().then((value) {
        videoPlayerController.pause();
        videoPlayerController.setVolume(0);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
