part of 'image_list_bloc.dart';

interface class ImageListState {}

final class ImageListInitialState extends ImageListState {
  var images;

  ImageListInitialState({required this.images});
}
