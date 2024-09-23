import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PhysicsVideosPage extends StatefulWidget {
  @override
  _PhysicsVideosPageState createState() => _PhysicsVideosPageState();
}

class _PhysicsVideosPageState extends State<PhysicsVideosPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Load the appropriate video for physics
    _controller = VideoPlayerController.network('https://firebasestorage.googleapis.com/v0/b/apt3065-5a3ea.appspot.com/o/pendulum.mp4?alt=media&token=b25ed0aa-1e6c-422e-bee7-eb13f281ecef');
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
              return Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  // Arrow button to redirect to labs page
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/physics_labs');
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
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
