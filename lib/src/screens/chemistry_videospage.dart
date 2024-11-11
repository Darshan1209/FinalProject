import 'dart:developer';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChemistryVideosPage extends StatefulWidget {
  const ChemistryVideosPage({super.key});

  @override
  State<ChemistryVideosPage> createState() => _ChemistryVideosPageState();
}

class _ChemistryVideosPageState extends State<ChemistryVideosPage> {
  late FlickManager flickManager;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    super.initState();
    log("ASBHAJSJDKASD");
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(
            "https://firebasestorage.googleapis.com/v0/b/apt3065-5a3ea.appspot.com/o/diffusion.mp4?alt=media&token=3c6f06bb-70d2-477a-b3a3-9675c02049a6")));

    // _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Blahhhh");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            top: 170.0), // Adjust the top padding as needed
        child: AspectRatio(
            aspectRatio: 16 / 10,
            child: FlickVideoPlayer(flickManager: flickManager)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
