import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_upload_image_video/utils.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? videoPath;
  VideoPlayerController? videoPlayerController;

  @override
  void dispose() {
    videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Upload Image Video'),
      ),
      body: videoPath != null
          ? Center(child: videoPreview())
          : const Center(
              child: Text('No video selected'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          videoPicker();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  videoPicker() async {
    videoPath = await pickVideo();
    initializeVideoPlayer();
  }

  initializeVideoPlayer() {
    videoPlayerController = VideoPlayerController.file(File(videoPath!))
      ..initialize().then((value) {
        setState(() {
          videoPlayerController!.play();
        });
      });
  }

  Widget videoPreview() {
    return Container(
      child: videoPlayerController!.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(videoPlayerController!),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
