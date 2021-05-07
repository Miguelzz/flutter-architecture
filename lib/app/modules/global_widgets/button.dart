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

class ButtonLoadingFullScreen extends StatelessWidget {
  final Widget child;
  final String title;
  final Future<void> Function()? onPressed;
  final Future<void> Function()? after;
  const ButtonLoadingFullScreen(
      {required this.onPressed,
      required this.after,
      required this.child,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed != null
          ? () async {
              bool stop = false;
              try {
                Get.defaultDialog(
                  title: title,
                  content: CircularProgressIndicator(),
                  onWillPop: () async {
                    while (!stop) {
                      await Future.delayed(Duration(milliseconds: 500));
                    }
                    return true;
                  },
                );
                FocusScope.of(context).unfocus();
                await onPressed!();
                stop = true;
                Get.back();
                await after!();
              } catch (e) {
                stop = true;
                Get.back();
              }
            }
          : null,
      child: child,
    );
  }
}
