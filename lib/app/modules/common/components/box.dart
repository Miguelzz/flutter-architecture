import 'package:flutter/material.dart';

class Box extends StatefulWidget {
  final Widget? child;
  final Color? backgroundColor, borderColor;
  final EdgeInsetsGeometry? margin, padding;
  final Radius? borderRadius;
  final double? width, height, minWidth, maxWidth, minHeight, maxHeight;
  final void Function()? onTap;
  Box(
      {this.backgroundColor,
      this.child,
      this.borderColor,
      this.margin,
      this.padding,
      this.borderRadius,
      this.minWidth,
      this.maxWidth,
      this.minHeight,
      this.maxHeight,
      this.width,
      this.height,
      this.onTap});

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    final container = Container(
      margin: widget.margin,
      padding: widget.padding,
      width: widget.width ?? double.infinity,
      height: widget.height,
      constraints: BoxConstraints(
        minWidth: widget.minWidth ?? 0,
        minHeight: widget.minHeight ?? 0,
        maxWidth: widget.maxWidth ?? double.infinity,
        maxHeight: widget.maxHeight ?? double.infinity,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(color: widget.borderColor ?? Colors.transparent),
        borderRadius:
            BorderRadius.all(widget.borderRadius ?? Radius.circular(0)),
      ),
      child: widget.child,
    );

    return widget.onTap == null
        ? container
        : InkWell(onTap: widget.onTap, child: container);
  }
}
