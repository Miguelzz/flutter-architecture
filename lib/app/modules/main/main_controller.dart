import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MainController extends GetxController {
  File? image;
  String url = 'assets/images/camera.png';
  final picker = ImagePicker();

  changueImage(PickedFile? pickedFile) {
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    } else {
      print('No image selected.');
    }
  }

  @override
  void onInit() async {
    super.onInit();

    print('MAIN');
  }
}
