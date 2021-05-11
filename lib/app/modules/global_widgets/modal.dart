import 'package:flutter_architecture/app/modules/global_widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

openModal(
  BuildContext context, {
  required Widget child,
  BehaviorSubject<bool>? enabledFloat,
  void Function()? onPressedFloating,
  required void Function() closeModal,
  IconData? iconFloating,
  double? width,
  double? height,
  double? borderRadius,
  EdgeInsetsGeometry? padding,
}) {
  final size = MediaQuery.of(context).size;
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __) {
        return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.30),
          body: SafeArea(
            child: Stack(
              children: [
                Box(
                  width: double.infinity,
                  height: double.infinity,
                  onTap: () {
                    closeModal();
                    Navigator.of(context).pop();
                  },
                ),
                Center(
                  child: AbsorbPointer(
                    child: Box(
                      width: width ?? size.width * 0.8,
                      height: height ?? size.height * 0.7,
                    ),
                  ),
                ),
                Center(
                  child: Box(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    width: width ?? size.width * 0.8,
                    height: height ?? size.height * 0.7,
                    borderRadius: Radius.circular(borderRadius ?? 5),
                    padding: padding ?? EdgeInsets.all(7),
                    margin: EdgeInsets.only(bottom: 7),
                    child: child,
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: onPressedFloating != null
              ? StreamBuilder<bool>(
                  stream: enabledFloat?.stream,
                  builder: (_, snapshot) {
                    bool enabled = snapshot.data ?? false;
                    return enabled
                        ? FloatingActionButton(
                            child: Icon(iconFloating),
                            onPressed: () {
                              onPressedFloating();
                              Navigator.of(context).pop();
                            },
                          )
                        : FloatingActionButton(
                            backgroundColor: Theme.of(context).disabledColor,
                            child: Icon(iconFloating ?? Icons.arrow_forward,
                                color: Colors.white60),
                            onPressed: () {},
                          );
                  })
              : null,
        );
      },
      fullscreenDialog: true,
    ),
  );
}
