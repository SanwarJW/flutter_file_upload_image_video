import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_upload_image_video/utils.dart';
import 'package:flutter_file_upload_image_video/widget/image_widget.dart';
import 'package:flutter_file_upload_image_video/widget/video_widget.dart';
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

  void videoPicker() async {
    videoPath = await pickVideo();
    videoPlayerController = VideoPlayerController.file(File(videoPath!))
      ..initialize().then(
        (value) {
          setState(() {
            videoPlayerController;
          });
        },
      );
  }

  imagePicker() async {
    imagePath = await pickImage();
    setState(() {
      if (imagePath != null) {
        imageFile = File(imagePath!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Upload Image Video'),
          backgroundColor: Colors.orange,
        ),
        body: imageOrVideoSelected(),
        floatingActionButton: selectFloatingActionButton());
  }

  Widget imageOrVideoSelected() {
    return imageOrVideo
        ? videoPath != null
            ? Center(
                child: VideoPreviewWidget(
                    downloadUrl: downloadUrl,
                    videoPath: videoPath,
                    videoPlayerController: videoPlayerController!))
            : const Center(
                child: Text('No item selected'),
              )
        : imagePath != null
            ? Center(
                child: ImagePreviewWidget(
                  imagePath: imagePath,
                  imageFile: imageFile!,
                ),
              )
            : const Center(
                child: Text('No item selected'),
              );
  }

  Widget selectFloatingActionButton() {
    return Column(
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
    );
  }
}
