import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_upload_image_video/Presentation_layer/image_list/bloc/image_list_bloc.dart';

ImageListBloc imageListBloc = ImageListBloc();

class ImageList extends StatelessWidget {
  const ImageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image List'),
      ),
      body: BlocBuilder<ImageListBloc, ImageListState>(
        bloc: imageListBloc,
        builder: (context, state) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('images').snapshots(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.network(snapshot.data!.docs[index]['url']),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
