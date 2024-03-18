part of 'image_list_bloc.dart';

interface class ImageListEvent {}

final class ImageListInitialEvent extends ImageListEvent {}

class ImageListFetchEvent extends ImageListEvent {}
