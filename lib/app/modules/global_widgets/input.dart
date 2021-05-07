import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/global_widgets/box.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class TextArea extends StatelessWidget {
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final String? labelText;
  final bool? enabled, ignoring;
  final int? debounce;
  final EdgeInsetsGeometry? margin;
  final void Function(String)? onChanged;
  final double? width;
  final int? maxLines, minLines, maxLength;

  TextArea({
    this.controller,
    this.labelText,
    this.margin,
    this.enabled,
    this.debounce,
    this.textAlign,
    this.onChanged,
    this.width,
    this.ignoring,
    this.maxLines,
    this.minLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Input(
      controller: this.controller,
      labelText: this.labelText,
      margin: this.margin,
      enabled: this.enabled,
      debounce: this.debounce,
      textAlign: this.textAlign,
      onChanged: this.onChanged,
      width: this.width,
      ignoring: this.ignoring,
      keyboardType: TextInputType.multiline,
      maxLines: this.maxLines,
      minLines: this.minLines,
      maxLength: this.maxLength,
    );
  }
}

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
  final int? maxLines;
  final int? maxLength;
  final int? minLines;

  Input({
    this.controller,
    this.keyboardType,
    this.labelText,
    this.margin,
    this.enabled,
    this.debounce,
    this.textAlign,
    this.onChanged,
    this.width,
    this.ignoring,
    this.maxLines,
    this.maxLength,
    this.minLines,
  });

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
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
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
