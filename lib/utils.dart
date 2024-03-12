import 'package:image_picker/image_picker.dart';

pickVideo() async {
  final picker = ImagePicker();
  XFile? pickedFile;
  try {
    pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    return pickedFile!.path;
  } catch (e) {
    print('error picking video $e');
  }
}
