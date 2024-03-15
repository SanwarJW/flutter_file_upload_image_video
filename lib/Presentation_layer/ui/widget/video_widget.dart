import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_upload_image_video/Presentation_layer/bloc/home_bloc.dart';
import 'package:flutter_file_upload_image_video/Presentation_layer/ui/home_page.dart';
import 'package:flutter_file_upload_image_video/store_data.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoPreviewWidget extends StatefulWidget {
  VideoPlayerController? videoPlayerController;
  String? downloadUrl;
  String? videoPath;
  final double videoSizeInMB;
  final HomeBloc homeBloc;
  VideoPreviewWidget(
      {super.key,
      required this.videoPlayerController,
      required this.videoPath,
      required this.videoSizeInMB,
      required this.homeBloc});

  @override
  State<VideoPreviewWidget> createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeVideoWidgetInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return widget.videoPath != null
        ? Container(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<HomeBloc, HomeState>(
              bloc: widget.homeBloc,
              buildWhen: (previous, current) => current is HomeVideoWidgetState,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case const (HomeVideoWidgetInitialState):
                    return Column(
                      children: [
                        LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            double maxWidth = constraints.maxWidth;

                            double aspectRatio =
                                widget.videoPlayerController!.value.aspectRatio;
                            double calculatedHeight = maxWidth / aspectRatio;
                            double height =
                                calculatedHeight > 500 ? 500 : calculatedHeight;
                            if (height >= 500) {
                              return AspectRatio(
                                aspectRatio: 4 / 5,
                                child: SizedBox(
                                  width: maxWidth,
                                  height: height,
                                  child: VideoPlayer(
                                      widget.videoPlayerController!),
                                ),
                              );
                            } else {
                              return AspectRatio(
                                aspectRatio: aspectRatio,
                                child: SizedBox(
                                  width: maxWidth,
                                  height: height,
                                  child: VideoPlayer(
                                      widget.videoPlayerController!),
                                ),
                              );
                            }
                          },
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
                              child:
                                  widget.videoPlayerController!.value.isPlaying
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
                    );
                  case const (HomeVideoWidgetLoadingState):
                    return Center(
                      child: Lottie.asset('assets/animation/loading.json'),
                    );
                  case const (HomeVideoWidgetUploadSuccessState):
                    return const Center(
                      child: Text('Upload successfully'),
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ))
        : const Center(
            child: Text('Upload successfully'),
          );
  }

  void uploadVideo() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    // print(connectivityResult == ConnectivityResult.ethernet);
    if (connectivityResult != ConnectivityResult.none) {
      if (widget.videoSizeInMB < 10) {
        homeBloc.add(HomeVideoWidgetUploadButtonClickedEvent());
        widget.downloadUrl =
            await StoreData().uploadVideoToStorage(widget.videoPath!);
        await StoreData().saveVideoToFirestore(widget.downloadUrl!);
        homeBloc.add(HomeVideoWidgetUploadSuccessEvent());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video size should be less than 10MB'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection'),
        ),
      );
    }
  }
}
