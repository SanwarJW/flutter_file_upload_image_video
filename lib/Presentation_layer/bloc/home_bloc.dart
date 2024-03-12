import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_file_upload_image_video/utils.dart';
import 'package:video_player/video_player.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late String videoPath;
  String? imagePath;
  late VideoPlayerController videoPlayerController;
  File? imageFile;

  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeAddVideoButtonClickedEvent>(addVideoButtonClickedEvent);
    on<HomeAddImageButtonClickedEvent>(addImageButtonClickedEvent);
  }
  videoPicker() async {
    videoPath = await pickVideo();
    videoPlayerController = VideoPlayerController.file(File(videoPath))
      ..initialize();
  }

  imagePicker() async {
    imagePath = await pickImage();

    if (imagePath != null) {
      imageFile = File(imagePath!);
    }
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeInitialState());
  }

  Future<FutureOr<void>> addVideoButtonClickedEvent(
      HomeAddVideoButtonClickedEvent event, Emitter<HomeState> emit) async {
    await videoPicker();

    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(HomeVideoSelectedState(
        videoPath: videoPath, videoPlayerController: videoPlayerController));
  }

  Future<FutureOr<void>> addImageButtonClickedEvent(
      HomeAddImageButtonClickedEvent event, Emitter<HomeState> emit) async {
    await imagePicker();
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(HomeImageSelectedState(imageFile: imageFile, imagePath: imagePath));
  }
}
