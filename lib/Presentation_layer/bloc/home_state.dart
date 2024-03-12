part of 'home_bloc.dart';

interface class HomeState {}

class HomeActionState extends HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeVideoSelectedState extends HomeState {
  final String? videoPath;
  final VideoPlayerController? videoPlayerController;
  HomeVideoSelectedState(
      {required this.videoPath, required this.videoPlayerController});
}

final class HomeImageSelectedState extends HomeState {
  final String? imagePath;
  final File? imageFile;

  HomeImageSelectedState({required this.imagePath, required this.imageFile});
}
