import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider with ChangeNotifier {
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  ///Opens gallery to load a image
  void selectImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  ///Removes the loaded image
  void empty() {
    image = null;
    notifyListeners();
  }
}
