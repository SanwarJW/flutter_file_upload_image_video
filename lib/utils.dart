import 'package:image_picker/image_picker.dart';

pickVideo() async {
  final picker = ImagePicker();
  XFile? pickedVideo;
  try {
    pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    return pickedVideo!.path;
  } catch (e) {
    print('error picking video $e');
  }
}

pickImage() async {
  final picker = ImagePicker();
  XFile? pickedImage;
  try {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    return pickedImage!.path;
  } catch (e) {
    print('error picking image $e');
  }
}
