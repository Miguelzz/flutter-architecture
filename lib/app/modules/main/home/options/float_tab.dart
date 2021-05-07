import 'package:flutter_architecture/app/modules/global_widgets/fullscreen.dart';
import 'package:flutter_architecture/app/modules/global_widgets/image_upload.dart';
import 'package:flutter_architecture/app/modules/global_widgets/input.dart';
import 'package:flutter_architecture/app/modules/global_widgets/modal.dart';
import '../home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget floatTab(BuildContext context, int index) {
  final options = [
    // ONE
    FloatingActionButton(onPressed: () {}, child: Icon(Icons.looks_one)),
    // TWO
    FloatingActionButton(
        onPressed: () {
          String _image = '';
          String _title = '';
          String _description = '';
          openModal(
            context,
            iconFloating: Icons.save,
            onPressedFloating: () {
              print(_image);
              print(_title);
              print(_description);

              // if (_image != '') {
              //   File(_image).delete();
              //   _image = '';
              // }
            },
            child: FullScreen(
              child: Column(
                children: [
                  UploadImagePreview(
                    title: 'Photo producto',
                    changueImage: (image) {
                      _image = image ?? '';
                    },
                  ),
                  Input(
                    onChanged: (value) => _title = value,
                    margin: EdgeInsets.only(bottom: 12, top: 30),
                    labelText: 'Titulo Producto',
                  ),
                  TextArea(
                    onChanged: (value) => _description = value,
                    margin: EdgeInsets.only(bottom: 12),
                    labelText: 'Descripción Producto',
                  ),
                ],
              ),
            ),
            closeModal: () {},
          );

          // List<String> _listImages = [];
          // openModal(
          //   context,
          //   height: MediaQuery.of(context).size.width * 0.8,
          //   onPressedFloating: () {
          //     print(_listImages);
          //     // _listImages.forEach((url) {
          //     //   try {
          //     //     if (url != '') File(url).delete();
          //     //   } catch (e) {}
          //     // });
          //   },
          //   closeModal: () {
          //   },
          //   child: UploadImageMultiple(
          //     maxImage: 5,
          //     changueImages: (images) {
          //       _listImages = images;
          //     },
          //   ),
          // );
        },
        child: Icon(Icons.home)),
    // THREE
    FloatingActionButton(onPressed: () {}, child: Icon(Icons.looks_two))
  ];

  return options[index];
}

class FloatTab extends StatelessWidget {
  @override
  Widget build(context) => GetBuilder<HomeController>(
        id: 'float_tap',
        builder: (_) => floatTab(context, _.indexTab),
      );
}
