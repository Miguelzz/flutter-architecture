import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/global_widgets/modal.dart';
import 'package:flutter_architecture/app/modules/global_widgets/fonts.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_architecture/app/modules/global_widgets/box.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';

bool isImageFile(String url) {
  return (url != '' &&
      !RegExp(r"^assets\/images").hasMatch(url) &&
      !RegExp(r"^(ftp|http|https):\/\/").hasMatch(url));
}

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
  final void Function(String? url) cropImage;
  UploadImagePreview({
    required this.title,
    required this.changueImage,
    required this.cropImage,
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
      if (isImageFile(url)) {
        File(url).delete();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final image = imageComponent(url);

    return InkWell(
      onTap: () {
        final size = MediaQuery.of(context).size;
        openModal(
          context,
          height: size.width * 0.9,
          width: size.width * 0.9,
          child: ClipRRect(
            child: PhotoView.customChild(child: image),
          ),
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
                  await showSelectionDialog(context, widget.title, url,
                      (image) {
                    setState(() {
                      url = image ?? '';
                      widget.changueImage(image);
                    });
                  }, (image) {
                    setState(() {
                      url = image ?? '';
                      widget.cropImage(image);
                    });
                  });
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 200),
                  child: Box(
                    height: 30,
                    width: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: widget.padding,
                    child: Icon(
                      Icons.camera_alt,
                      size: 15,
                      color: Theme.of(context).indicatorColor,
                    ),
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

class CropImage extends StatefulWidget {
  final String url;
  final void Function(String? url) cropImage;
  CropImage(this.url, this.cropImage);
  @override
  _CropImageState createState() => _CropImageState();
}

class _CropImageState extends State<CropImage> {
  final cropKey = GlobalKey<CropState>();
  late File _image;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    print(widget.url);
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Icon(Icons.save),
                      onTap: () async {
                        await _cropImage();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}

Future<void> showSelectionDialog(
  BuildContext context,
  String title,
  String url,
  void Function(String? url) changueImage,
  void Function(String? url) cropImage,
) {
  final picker = ImagePicker();
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Box(
        margin: EdgeInsets.all(7),
        height: 115,
        child: Column(
          children: [
            H6(title, margin: EdgeInsets.only(bottom: 12)),
            Row(
              children: [
                CircleIcon(
                    icon: Icons.camera_alt,
                    title: 'Cámara',
                    onTap: () async {
                      var pickedFile =
                          await picker.getImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        changueImage(pickedFile.path);
                      } else {
                        print('No image selected.');
                      }
                      Navigator.of(context).pop();
                    }),
                CircleIcon(
                  icon: Icons.image,
                  title: 'Galería',
                  onTap: () async {
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
                if (isImageFile(url))
                  CircleIcon(
                    icon: Icons.crop,
                    title: 'Recortar',
                    onTap: () {
                      final size = MediaQuery.of(context).size;
                      openModal(
                        context,
                        height: size.width * 0.9,
                        child: CropImage(url, cropImage),
                      );
                    },
                  ),
                if (isImageFile(url))
                  CircleIcon(
                    icon: Icons.delete,
                    title: 'Eliminar',
                    onTap: () {
                      File(url).delete();
                      changueImage('');
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  CircleIcon({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Box(
      height: 70,
      width: 80,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Box(
              height: 37,
              width: 37,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                icon,
                size: 15,
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ),
          P(
            title,
            textAlign: TextAlign.center,
            margin: EdgeInsets.only(top: 5),
          )
        ],
      ),
    );
  }
}
