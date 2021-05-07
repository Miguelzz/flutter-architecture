import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/constants.dart';

class FullScreen extends StatelessWidget {
  final bool safeArea;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  FullScreen({required this.child, this.padding, this.safeArea = false});

  @override
  Widget build(BuildContext context) {
    return safeArea ? SafeArea(child: full()) : full();
  }

  Widget full() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: ConstrainedBox(
          constraints: constraints.copyWith(
              minHeight: constraints.maxHeight, maxHeight: double.infinity),
          child: Container(
              padding: padding ?? EdgeInsets.all(Constants.FULL_SCREEN_PADDING),
              child: child),
        ),
      );
    });
  }
}
