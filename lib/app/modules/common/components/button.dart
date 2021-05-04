import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/theme.dart';
import 'package:get/get.dart';

class ButtonLoading extends StatefulWidget {
  final Widget child;
  final Future<void> Function()? onPressed;
  const ButtonLoading({required this.onPressed, required this.child});

  @override
  _ButtonLoadingState createState() => _ButtonLoadingState();
}

class _ButtonLoadingState extends State<ButtonLoading> {
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled && widget.onPressed != null
          ? () async {
              try {
                FocusScope.of(context).unfocus();
                setState(() => enabled = false);
                await widget.onPressed!();
                setState(() => enabled = true);
              } catch (e) {
                setState(() => enabled = true);
              }
            }
          : null,
      child: enabled
          ? widget.child
          : SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class ButtonLoadingFullScreen extends StatefulWidget {
  final Widget child;
  final String title;
  final Future<void> Function()? onPressed;
  const ButtonLoadingFullScreen(
      {required this.onPressed, required this.child, required this.title});

  @override
  _ButtonLoadingFullScreenState createState() =>
      _ButtonLoadingFullScreenState();
}

class _ButtonLoadingFullScreenState extends State<ButtonLoadingFullScreen> {
  bool enabled = true;
  bool _stop = true;

  Future<bool> _stopDialog() async {
    while (!_stop) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    return _stop;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled && widget.onPressed != null
          ? () async {
              try {
                _stop = false;
                Get.defaultDialog(
                    title: widget.title,
                    content: CircularProgressIndicator(
                        backgroundColor: PRIMARY_COLOR),
                    onWillPop: () async => await _stopDialog());
                FocusScope.of(context).unfocus();
                setState(() => enabled = false);
                await widget.onPressed!();
                setState(() => enabled = true);
              } catch (e) {
                setState(() => enabled = true);
              }
            }
          : null,
      child: widget.child,
    );
  }
}
