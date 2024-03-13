part of 'home_bloc.dart';

interface class HomeState {}

class HomeHomeState extends HomeState {}

class HomeActionState extends HomeState {}

final class HomeVideoWidgetState extends HomeState {}

final class HomeImageWidgetState extends HomeState {}

final class HomeInitialState extends HomeHomeState {}

final class HomeLoadingState extends HomeHomeState {}

final class HomeVideoSelectedState extends HomeHomeState {
  final String? videoPath;
  final double videoSizeInMB;
  final VideoPlayerController? videoPlayerController;
  HomeVideoSelectedState(
      {required this.videoPath,
      required this.videoPlayerController,
      required this.videoSizeInMB});
}

final class HomeImageSelectedState extends HomeHomeState {
  final double imageSizeInMB;
  final String? imagePath;
  final File? imageFile;

  HomeImageSelectedState(
      {required this.imagePath,
      required this.imageFile,
      required this.imageSizeInMB});
}

final class HomeVideoWidgetInitialState extends HomeVideoWidgetState {}

final class HomeVideoWidgetLoadingState extends HomeVideoWidgetState {}

final class HomeVideoWidgetUploadSuccessState extends HomeVideoWidgetState {}

final class HomeImageWidgetInitialState extends HomeImageWidgetState {}

final class HomeImageWidgetLoadingState extends HomeImageWidgetState {}

final class HomeImageWidgetUploadSuccessState extends HomeImageWidgetState {}
