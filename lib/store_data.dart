import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadFile(String videoUrl) async {
    Reference ref = storage.ref().child('videos/${DateTime.now()}.mp4');
    await ref.putFile(File(videoUrl));
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> saveVideo(String videoDownloadUrl) async {
    await firestore.collection('videos').add({
      'url': videoDownloadUrl,
      'timestamp': FieldValue.serverTimestamp(),
      'name': 'Flutter Upload Video'
    });
  }
}
