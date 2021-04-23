import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final String? labelText;
  final bool? enabled;
  final int? debounce;
  final EdgeInsetsGeometry? margin;
  final void Function(String)? onChanged;

  Input(
      {this.controller,
      this.keyboardType,
      this.labelText,
      this.margin,
      this.enabled,
      this.debounce,
      this.textAlign,
      this.onChanged});

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  late Timer _debounce =
      Timer(Duration(milliseconds: widget.debounce ?? 0), () {});

  @override
  void dispose() {
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Box(
      margin: widget.margin,
      child: TextField(
        controller: widget.controller,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged != null
            ? (value) {
                if (_debounce.isActive) _debounce.cancel();
                _debounce =
                    Timer(Duration(milliseconds: widget.debounce ?? 0), () {
                  widget.onChanged!(value);
                });
              }
            : null,
        textAlign: widget.textAlign ?? TextAlign.start,
        decoration: InputDecoration(
          // border: OutlineInputBorder(),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
