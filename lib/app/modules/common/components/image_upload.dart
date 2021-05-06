import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/common/components/modal.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';
import 'package:path_provider/path_provider.dart';

Widget imageComponent(String url) {
  late Widget image;
  if (RegExp(r"^assets\/images").hasMatch(url)) {
    image = Image.asset(url, fit: BoxFit.cover);
  } else if (RegExp(r"^(ftp|http|https):\/\/").hasMatch(url)) {
    image = Image.network(url, fit: BoxFit.cover);
  } else if (url == '') {
    image = Box(backgroundColor: Colors.grey);
  } else {
    image = Image.file(File(url), fit: BoxFit.cover);
  }
  return image;
}

class UploadImage extends StatelessWidget {
  final String title;
  final Widget child;
  UploadImage({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class UploadImagePreview extends StatefulWidget {
  final String title;
  final String? url;
  final double? height, width, borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final void Function(String? url) changueImage;
  final void Function(String? url)? cropImage;
  UploadImagePreview({
    required this.title,
    required this.changueImage,
    this.cropImage,
    this.url,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
  });

  @override
  _UploadImagePreviewState createState() => _UploadImagePreviewState();
}

class _UploadImagePreviewState extends State<UploadImagePreview> {
  late String url;
  @override
  void initState() {
    super.initState();
    url = widget.url ?? '';
  }

  @override
  dispose() {
    super.dispose();
    try {
      if (url != '' &&
          !RegExp(r"^assets\/images").hasMatch(url) &&
          !RegExp(r"^(ftp|http|https):\/\/").hasMatch(url)) {
        File(url).delete();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final image = imageComponent(url);
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () async {
        if (url != '' &&
            !RegExp(r"^assets\/images").hasMatch(url) &&
            !RegExp(r"^(ftp|http|https):\/\/").hasMatch(url))
          openModal(
            context,
            height: size.width * 0.9,
            child: EditImage(url, (value) {
              if (widget.cropImage != null) widget.cropImage!(value);
              setState(() {
                if (value != null) url = value;
              });
            }),
          );
      },
      child: UploadImage(
        title: widget.title,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 200),
              child: Box(
                height: widget.height ?? 100,
                width: widget.width ?? 100,
                backgroundColor: widget.backgroundColor,
                padding: widget.padding,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 200),
                  child: image,
                ),
              ),
            ),
            Positioned(
              bottom: 3,
              right: 3,
              child: InkWell(
                onTap: () async {
                  await showSelectionDialog(context, widget.title,
                      (image) async {
                    setState(() {
                      url = image ?? '';
                      widget.changueImage(image);
                    });
                  });
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 200),
                  child: Box(
                    height: widget.height ?? 30,
                    width: widget.width ?? 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: widget.padding,
                    child: Icon(Icons.camera_alt, size: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditImage extends StatefulWidget {
  final String url;
  final void Function(String? url) cropImage;
  EditImage(this.url, this.cropImage);
  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  final cropKey = GlobalKey<CropState>();
  late File _image;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _image = File(widget.url);
  }

  Future<void> _cropImage() async {
    final area = cropKey.currentState!.area;
    if (area == null) return;
    final file = await ImageCrop.cropImage(
      file: _image,
      area: area,
    );

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String bgPath = appDocDir.uri
        .resolve("image-${DateTime.now().millisecondsSinceEpoch}.jpg")
        .path;

    if (_image.path != '' &&
        !RegExp(r"^assets\/images").hasMatch(_image.path) &&
        !RegExp(r"^(ftp|http|https):\/\/").hasMatch(_image.path)) {
      File(_image.path).delete();
    }

    _image = await file.copy(bgPath);
    file.delete();
    widget.cropImage(_image.path);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //final scale = cropKey.currentState!.scale;
    return FutureBuilder<File>(
        future: ImageCrop.sampleImage(
          file: _image,
          preferredSize: (2000 / 1).round(),
        ),
        builder: (context, snapshot) {
          if (snapshot.data == null) return Container();
          return Column(
            children: [
              Expanded(
                child: Crop.file(
                  snapshot.data!,
                  key: cropKey,
                  aspectRatio: 1,
                  alwaysShowGrid: true,
                ),
              ),
              Box(
                padding: EdgeInsets.only(top: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Icon(Icons.save),
                      onTap: _cropImage,
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}

Future<void> showSelectionDialog(BuildContext context, String title,
    void Function(String? url) changueImage) {
  final picker = ImagePicker();
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
                  var pickedFile =
                      await picker.getImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    changueImage(pickedFile.path);
                  } else {
                    print('No image selected.');
                  }
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text("Camera"),
                onPressed: () async {
                  var pickedFile =
                      await picker.getImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    changueImage(pickedFile.path);
                  } else {
                    print('No image selected.');
                  }
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
