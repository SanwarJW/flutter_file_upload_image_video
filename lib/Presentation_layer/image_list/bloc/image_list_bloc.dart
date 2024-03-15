import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'image_list_event.dart';
part 'image_list_state.dart';

class ImageListBloc extends Bloc<ImageListEvent, ImageListState> {
  ImageListBloc() : super(ImageListInitialState(images: imageFetch())) {
    on<ImageListInitialEvent>(_onImageListInitialEvent);
  }

  FutureOr<void> _onImageListInitialEvent(
      ImageListInitialEvent event, Emitter<ImageListState> emit) {
    emit(ImageListInitialState(images: imageFetch()));
  }
}

imageFetch() async {
  var images = FirebaseFirestore.instance.collection('images').snapshots();
  return images;
}
