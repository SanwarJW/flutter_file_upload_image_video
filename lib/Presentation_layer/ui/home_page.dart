import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_upload_image_video/Presentation_layer/bloc/home_bloc.dart';
import 'package:flutter_file_upload_image_video/Presentation_layer/ui/widget/image_widget.dart';
import 'package:flutter_file_upload_image_video/Presentation_layer/ui/widget/video_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

HomeBloc homeBloc = HomeBloc();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          title: const Text('Flutter Upload Image Video'),
          backgroundColor: Colors.orange,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          bloc: homeBloc,
          buildWhen: (previous, current) => current is HomeHomeState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case const (HomeInitialState):
                return const Center(
                  child: Text('No item selected'),
                );

              case const (HomeLoadingState):
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case const (HomeVideoSelectedState):
                final homeVideoSelectedState = state as HomeVideoSelectedState;
                print('size of a video $homeVideoSelectedState.videoSizeInMB');
                return Center(
                    child: VideoPreviewWidget(
                  homeBloc: homeBloc,
                  videoSizeInMB: homeVideoSelectedState.videoSizeInMB,
                  videoPath: homeVideoSelectedState.videoPath,
                  videoPlayerController:
                      homeVideoSelectedState.videoPlayerController,
                ));

              case const (HomeImageSelectedState):
                final homeImageSelectedState = state as HomeImageSelectedState;
                return Center(
                  child: ImagePreviewWidget(
                    imageSizeInMB: homeImageSelectedState.imageSizeInMB,
                    homeBloc: homeBloc,
                    imagePath: homeImageSelectedState.imagePath,
                    imageFile: homeImageSelectedState.imageFile!,
                  ),
                );

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
        floatingActionButton: selectFloatingActionButton());
  }

  Widget selectFloatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            print('video button clicked');
            homeBloc.add(HomeAddVideoButtonClickedEvent());
          },
          child: const Icon(Icons.video_call_outlined),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: () {
            homeBloc.add(HomeAddImageButtonClickedEvent());
          },
          child: const Icon(Icons.image),
        )
      ],
    );
  }
}
