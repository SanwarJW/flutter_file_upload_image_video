// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_file_upload_image_video/Presentation_layer/image_list/bloc/image_list_bloc.dart';

// ImageListBloc imageListBloc = ImageListBloc();

// class ImageList extends StatelessWidget {
//   const ImageList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image List'),
//       ),
//       body: BlocBuilder<ImageListBloc, ImageListState>(
//         bloc: imageListBloc,
//         builder: (context, state) {
//           return StreamBuilder(
//             stream: FirebaseFirestore.instance.collection('images').snapshots(),
//             builder: (context, snapshot) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: const EdgeInsets.all(10),
//                     child: Image.network(snapshot.data!.docs[index]['url']),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

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
          switch (state.runtimeType) {
            // case const (ImageListLoadingState):
            //   return const Center(child: CircularProgressIndicator());
            case const (ImageListLoadingState):
              // final imageListInitialState = state is ImageListInitialState;
              return StreamBuilder<QuerySnapshot>(
                stream: //imageListInitialState.images,
                    FirebaseFirestore.instance.collection('images').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No images available'));
                  }
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
            default:
              return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
