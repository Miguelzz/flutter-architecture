import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  final Widget child;

  const FullScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: ConstrainedBox(
          constraints: constraints.copyWith(
              minHeight: constraints.maxHeight, maxHeight: double.infinity),
          child: child,
        ),
      );
    });
  }
}
