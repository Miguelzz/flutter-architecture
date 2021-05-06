import 'package:flutter_architecture/app/modules/common/components/box.dart';
import 'package:flutter_architecture/app/modules/common/components/fullscreen.dart';
import 'package:flutter_architecture/app/modules/common/components/image_upload.dart';
import 'package:flutter_architecture/app/modules/common/components/input.dart';
import 'package:flutter_architecture/app/modules/common/components/modal.dart';
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
          openModal(context,
              child: FullScreen(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UploadImagePreview(
                      title: 'Photo producto',
                      changueImage: (image) {
                        print('nueva imagen');
                        print(image);
                      },
                      cropImage: (image) {
                        print('cortar imagen');
                        print(image);
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Input(
                          margin: EdgeInsets.only(bottom: 12),
                          labelText: 'Titulo Producto',
                        ),
                        TextArea(
                          margin: EdgeInsets.only(bottom: 12),
                          labelText: 'Descripción Producto',
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: Text('Guardar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ));
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
