import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'image_list_event.dart';
part 'image_list_state.dart';

class ImageListBloc extends Bloc<ImageListEvent, ImageListState> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? imageListStream;
  ImageListBloc() : super(ImageListLoadingState()) {
    on<ImageListInitialEvent>(_onImageListInitialEvent);
    on<ImageListFetchEvent>(_onImageListFetchEvent);
  }

  Future<FutureOr<void>> _onImageListInitialEvent(
      ImageListInitialEvent event, Emitter<ImageListState> emit) async {
    emit(ImageListInitialState(images: imageFetch()));
  }

  FutureOr<void> _onImageListFetchEvent(
      ImageListFetchEvent event, Emitter<ImageListState> emit) {
    emit(ImageListLoadingState());
    imageFetch();
    emit(ImageListInitialState(images: imageListStream));
  }

  imageFetch() async {
    var images = FirebaseFirestore.instance.collection('images').snapshots();
    return imageListStream = images;
  }
}
