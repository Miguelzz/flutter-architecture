import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final String? labelText;
  final EdgeInsetsGeometry? margin;
  Input(
      {this.controller,
      this.keyboardType,
      this.labelText,
      this.margin,
      this.textAlign});

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Box(
      margin: widget.margin,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textAlign: widget.textAlign ?? TextAlign.start,
        decoration: InputDecoration(
          // border: OutlineInputBorder(),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
