import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChemistryVideosPage extends StatefulWidget {
  @override
  _ChemistryVideosPageState createState() => _ChemistryVideosPageState();
}

class _ChemistryVideosPageState extends State<ChemistryVideosPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Load the appropriate video for chemistry
    _controller = VideoPlayerController.network('https://firebasestorage.googleapis.com/v0/b/apt3065-5a3ea.appspot.com/o/diffusion.mp4?alt=media&token=3c6f06bb-70d2-477a-b3a3-9675c02049a6');
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 170.0), // Adjust the top padding as needed
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
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
