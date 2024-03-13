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
    on<HomeVideoWidgetInitialEvent>(homeVideoWidgetInitialEvent);
    on<HomeImageWidgetInitialEvent>(homeImageWidgetInitialEvent);
    on<HomeVideoWidgetUploadButtonClickedEvent>(
        homeVideoWidgetUploadButtonClickedEvent);
    on<HomeVideoWidgetUploadSuccessEvent>(homeVideoWidgetUploadSuccessEvent);
    on<HomeImageWidgetUploadButtonClickedEvent>(
        homeImageWidgetUploadButtonClickedEvent);
    on<HomeImageWidgetUploadSuccessEvent>(homeImageWidgetUploadSuccessEvent);
  }
  videoPicker() async {
    videoPath = await pickVideo();

    int size = File(videoPath).lengthSync();
    double sizeInMB = size / (1024 * 1024);
    videoPlayerController = VideoPlayerController.file(File(videoPath))
      ..initialize();
    return sizeInMB;
  }

  imagePicker() async {
    imagePath = await pickImage();
    imageFile = File(imagePath!);
    int size = await imageFile!.length();
    double imageSizeInMB = size / (1024 * 1024);
    return imageSizeInMB;
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeInitialState());
  }

  Future<FutureOr<void>> addVideoButtonClickedEvent(
      HomeAddVideoButtonClickedEvent event, Emitter<HomeState> emit) async {
    double videoSizeInMB = await videoPicker();

    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(HomeVideoSelectedState(
        videoPath: videoPath,
        videoPlayerController: videoPlayerController,
        videoSizeInMB: videoSizeInMB));
  }

  Future<FutureOr<void>> addImageButtonClickedEvent(
      HomeAddImageButtonClickedEvent event, Emitter<HomeState> emit) async {
    double imageSizeInMB = await imagePicker();
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(HomeImageSelectedState(
        imageFile: imageFile,
        imagePath: imagePath,
        imageSizeInMB: imageSizeInMB));
  }

  FutureOr<void> homeVideoWidgetInitialEvent(
      HomeVideoWidgetInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeVideoWidgetInitialState());
  }

  FutureOr<void> homeImageWidgetInitialEvent(
      HomeImageWidgetInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeImageWidgetInitialState());
  }

  FutureOr<void> homeImageWidgetUploadButtonClickedEvent(
      HomeImageWidgetUploadButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeImageWidgetLoadingState());
  }

  FutureOr<void> homeImageWidgetUploadSuccessEvent(
      HomeImageWidgetUploadSuccessEvent event, Emitter<HomeState> emit) {
    emit(HomeImageWidgetUploadSuccessState());
  }

  FutureOr<void> homeVideoWidgetUploadButtonClickedEvent(
      HomeVideoWidgetUploadButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeVideoWidgetLoadingState());
  }

  FutureOr<void> homeVideoWidgetUploadSuccessEvent(
      HomeVideoWidgetUploadSuccessEvent event, Emitter<HomeState> emit) {
    emit(HomeVideoWidgetUploadSuccessState());
  }
}
