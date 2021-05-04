import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class Input extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final String? labelText;
  final bool? enabled, ignoring;
  final int? debounce;
  final EdgeInsetsGeometry? margin;
  final void Function(String)? onChanged;
  final double? width;

  Input(
      {this.controller,
      this.keyboardType,
      this.labelText,
      this.margin,
      this.enabled,
      this.debounce,
      this.textAlign,
      this.onChanged,
      this.width,
      this.ignoring});

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
      width: widget.width,
      margin: widget.margin,
      child: IgnorePointer(
        ignoring: widget.ignoring ?? false,
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
      ),
    );
  }
}

class InputDate extends StatelessWidget {
  final DateTime? initialDateTime;
  final void Function(DateTime) onDateTimeChanged;
  final double? width;
  final String labelText;
  final int? debounce;

  InputDate(
      {this.initialDateTime,
      this.width,
      this.debounce,
      required this.labelText,
      required this.onDateTimeChanged});

  @override
  Widget build(BuildContext context) {
    Timer _debounce = Timer(Duration(milliseconds: debounce ?? 0), () {});

    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(labelText),
                content: Container(
                  height: 150,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: initialDateTime,
                      onDateTimeChanged: (value) {
                        if (_debounce.isActive) _debounce.cancel();
                        _debounce =
                            Timer(Duration(milliseconds: debounce ?? 0), () {
                          onDateTimeChanged(value);
                        });
                      }),
                ),
              );
            });
      }, // Handle your callback
      child: Input(
        width: width,
        controller: TextEditingController(
            text: DateFormat('MM/dd/yyyy')
                .format(initialDateTime ?? DateTime(DateTime.now().year - 18))),
        enabled: false,
        labelText: labelText,
        margin: EdgeInsets.only(bottom: 5),
      ),
    );
  }
}
