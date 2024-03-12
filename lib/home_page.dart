import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_upload_image_video/store_data.dart';
import 'package:flutter_file_upload_image_video/utils.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool imageOrVideo = true;
  String? videoPath;
  String? imagePath;
  VideoPlayerController? videoPlayerController;
  File? imageFile;

  String? downloadUrl;

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
      body: imageOrVideo
          ? videoPath != null
              ? Center(child: videoPreview())
              : const Center(
                  child: Text('No video selected'),
                )
          : imagePath != null
              ? Center(
                  child: Image.file(imageFile!),
                )
              : const Center(
                  child: Text('No image selected'),
                ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              imageOrVideo = true;
              videoPicker();
            },
            //add video icon
            child: const Icon(Icons.video_call_outlined),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              imageOrVideo = false;
              imagePicker();
            },
            child: const Icon(Icons.image),
          )
        ],
      ),
    );
  }

  videoPicker() async {
    videoPath = await pickVideo();
    initializeVideoPlayer();
  }

  imagePicker() async {
    imagePath = await pickImage();
    setState(() {
      if (imagePath != null) {
        imageFile = File(imagePath!);
      }
    });
  }

  initializeVideoPlayer() {
    videoPlayerController = VideoPlayerController.file(File(videoPath!))
      ..initialize().then((value) {
        setState(() {
          videoPlayerController!.play();
        });
      });
  }

  initializeImage() {
    videoPlayerController = VideoPlayerController.file(File(imagePath!))
      ..initialize().then((value) {
        setState(() {
          videoPlayerController!.play();
        });
      });
  }

  uploadVideo() async {
    downloadUrl = await StoreData().uploadFile(videoPath!);
    await StoreData().saveVideo(downloadUrl!);
    setState(() {
      videoPath = null;
    });
  }

  Widget videoPreview() {
    return Container(
      child: videoPlayerController!.value.isInitialized
          ? Column(
              children: [
                AspectRatio(
                  aspectRatio: videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(videoPlayerController!),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          videoPlayerController!.value.isPlaying
                              ? videoPlayerController!.pause()
                              : videoPlayerController!.play();
                        });
                      },
                      //play and pause icon
                      child: videoPlayerController!.value.isPlaying
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        uploadVideo();
                      },
                      child: const Icon(Icons.cloud_upload_outlined),
                    ),
                  ],
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
