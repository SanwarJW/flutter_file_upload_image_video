import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_list_event.dart';
part 'video_list_state.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState> {
  VideoListBloc() : super(VideoListInitial()) {
    on<VideoListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
