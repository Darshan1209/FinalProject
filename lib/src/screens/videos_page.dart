import 'package:apt3065/src/utils/consumers_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideosPage extends StatefulWidget {
  final String topicName;
  const VideosPage({Key? key, required this.topicName}) : super(key: key);
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        AsyncValue videosPagedata =
            ref.watch(topicVideosReaderProvider(widget.topicName));
        return videosPagedata.when(
          data: (videosData) {
            final String videoUrl = videosData[0]['video'];
            _controller = VideoPlayerController.network(videoUrl);
            _initializeVideoPlayerFuture = _controller.initialize();
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(top: 170.0),
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
          },
          error: (error, stack) => Text('Error: $error'),
          loading: () => const Text('Loading...'),
        );
      },
    );
  }
}
