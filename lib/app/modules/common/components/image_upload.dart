import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';
import 'package:flutter_architecture/app/modules/main/main_controller.dart';

class UploadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return InkWell(
        onTap: () async {
          await showSelectionDialog(context, 'Photo user');
        },
        child: _.image == null
            ? Box(
                margin: EdgeInsets.only(bottom: 15, top: 15),
                padding: EdgeInsets.all(30),
                height: 120,
                width: 120,
                borderRadius: Radius.circular(500),
                backgroundColor: Colors.grey,
                child: Image.asset(_.url, fit: BoxFit.cover))
            : Box(
                margin: EdgeInsets.only(bottom: 15, top: 15),
                height: 120,
                width: 120,
                borderRadius: Radius.circular(500),
                backgroundColor: Colors.grey,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: Image.file(
                    _.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      );
    });
  }
}

Future<void> showSelectionDialog(BuildContext context, String title) {
  MainController controller = Get.find();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: Text("Gallery"),
                onPressed: () async {
                  MainController controller = Get.find();
                  var pickedFile = await controller.picker
                      .getImage(source: ImageSource.gallery);
                  controller.changueImage(pickedFile);
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text("Camera"),
                onPressed: () async {
                  var pickedFile = await controller.picker
                      .getImage(source: ImageSource.camera);
                  controller.changueImage(pickedFile);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      );
    },
  );
}
