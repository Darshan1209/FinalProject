import 'dart:developer';

import 'package:apt3065/src/utils/consumers_helper.dart';
import 'package:flick_video_player/flick_video_player.dart';
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
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Blahhhh");
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        AsyncValue videosPagedata =
            ref.watch(topicVideosReaderProvider(widget.topicName));
        return videosPagedata.when(
          data: (videosData) {
            final String videoUrl = videosData[0]['video'];
            flickManager = FlickManager(
                videoPlayerController:
                    VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(top: 170.0),
                child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: FlickVideoPlayer(flickManager: flickManager)),
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {
              //     setState(() {
              //       if (_controller.value.isPlaying) {
              //         _controller.pause();
              //       } else {
              //         _controller.play();
              //       }
              //     });
              //   },
              //   child: Icon(
              //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              //   ),
              // ),
            );
          },
          error: (error, stack) => Text('Error: $error'),
          loading: () => const Text('Loading...'),
        );
      },
    );
  }
}
