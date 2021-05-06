import 'package:flutter_architecture/app/modules/common/components/box.dart';
import 'package:flutter/material.dart';

openModal(
  BuildContext context, {
  required Widget child,
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
                  onTap: Navigator.of(context).pop,
                ),
                Center(
                  child: AbsorbPointer(
                    child: Box(
                      width: width ?? size.width * 0.8,
                      height: height ?? size.height * 0.8,
                    ),
                  ),
                ),
                Center(
                  child: Box(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    width: width ?? size.width * 0.8,
                    height: height ?? size.height * 0.8,
                    borderRadius: Radius.circular(borderRadius ?? 5),
                    padding: padding ?? EdgeInsets.all(7),
                    margin: EdgeInsets.only(bottom: 7),
                    child: child,
                  ),
                )
              ],
            ),
          ),
        );
      },
      fullscreenDialog: true,
    ),
  );
}
