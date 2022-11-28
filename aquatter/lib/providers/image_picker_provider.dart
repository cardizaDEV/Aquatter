import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider with ChangeNotifier {
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  void selectImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  void empty() {
    image = null;
    notifyListeners();
  }
}
