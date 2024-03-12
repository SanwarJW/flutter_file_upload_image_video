import 'package:flutter/material.dart';
import 'package:flutter_file_upload_image_video/store_data.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoPreviewWidget extends StatefulWidget {
  VideoPlayerController? videoPlayerController;
  String? downloadUrl;
  String? videoPath;
  VideoPreviewWidget(
      {super.key,
      required this.videoPlayerController,
      required this.videoPath});

  @override
  State<VideoPreviewWidget> createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.videoPath != null
        ? Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: widget.videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(widget.videoPlayerController!),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.videoPlayerController!.value.isPlaying
                              ? widget.videoPlayerController!.pause()
                              : widget.videoPlayerController!.play();
                        });
                      },
                      //play and pause icon
                      child: widget.videoPlayerController!.value.isPlaying
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
            ))
        : const Center(
            child: Text('Upload successfully'),
          );
  }

  void uploadVideo() async {
    widget.downloadUrl = await StoreData().uploadVideo(widget.videoPath!);
    await StoreData().saveVideo(widget.downloadUrl!);
    setState(() {
      widget.videoPath = null;
    });
  }
}
