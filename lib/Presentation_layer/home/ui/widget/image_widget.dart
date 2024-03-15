// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_upload_image_video/Presentation_layer/home/bloc/home_bloc.dart';
import 'package:flutter_file_upload_image_video/Presentation_layer/home/ui/home_page.dart';
import 'package:flutter_file_upload_image_video/store_data.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ImagePreviewWidget extends StatefulWidget {
  final HomeBloc homeBloc;
  final File? imageFile;
  String? imagePath;
  final double imageSizeInMB;
  ImagePreviewWidget({
    super.key,
    required this.imageFile,
    required this.imagePath,
    required this.homeBloc,
    required this.imageSizeInMB,
  });

  @override
  State<ImagePreviewWidget> createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeImageWidgetInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: widget.homeBloc,
      buildWhen: (previous, current) => current is HomeImageWidgetState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeImageWidgetInitialState):
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.file(widget.imageFile!),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        uploadImage();
                      },
                      child: const Icon(Icons.cloud_upload_outlined))
                ],
              ),
            );
          case const (HomeImageWidgetLoadingState):
            return Center(
              child: Lottie.asset('assets/animation/loading.json'),
            );
          case const (HomeImageWidgetUploadSuccessState):
            return const Center(
              child: Text('Upload successfully'),
            );

          default:
            return const Center(
              child: Text('default'),
            );
        }
      },
    );
  }

  void uploadImage() async {
    if (widget.imageSizeInMB < 4) {
      widget.homeBloc.add(HomeImageWidgetUploadButtonClickedEvent());
      String downloadUrl =
          await StoreData().uploadImageToStorage(widget.imagePath!);
      await StoreData().saveImageToFirestore(downloadUrl);
      widget.homeBloc.add(HomeImageWidgetUploadSuccessEvent());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image size should be less than 10MB'),
        ),
      );
    }
  }
}
