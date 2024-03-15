part of 'home_bloc.dart';

interface class HomeEvent {}

class HomeVideoWidgetEvent extends HomeEvent {}

class HomeImageWidgetEvent extends HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeAddVideoButtonClickedEvent extends HomeEvent {}

class HomeAddImageButtonClickedEvent extends HomeEvent {}

class HomeVideoWidgetInitialEvent extends HomeVideoWidgetEvent {}

class HomeVideoWidgetUploadButtonClickedEvent extends HomeVideoWidgetEvent {}

class HomeVideoWidgetUploadSuccessEvent extends HomeVideoWidgetEvent {}

class HomeImageWidgetInitialEvent extends HomeImageWidgetEvent {}

class HomeImageWidgetUploadButtonClickedEvent extends HomeImageWidgetEvent {}

class HomeImageWidgetUploadSuccessEvent extends HomeImageWidgetEvent {}
