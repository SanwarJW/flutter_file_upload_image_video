// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_upload_image_video/store_data.dart';

// ignore: must_be_immutable
class ImagePreviewWidget extends StatefulWidget {
  final File? imageFile;
  String? imagePath;
  ImagePreviewWidget({
    super.key,
    required this.imageFile,
    required this.imagePath,
  });

  @override
  State<ImagePreviewWidget> createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.imagePath != null
        ? Container(
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
          )
        : const Center(
            child: Text('Upload successfully'),
          );
  }

  void uploadImage() async {
    String downloadUrl = await StoreData().uploadImage(widget.imagePath!);
    await StoreData().saveImage(downloadUrl);
    setState(() {
      widget.imagePath = null;
    });
  }
}
