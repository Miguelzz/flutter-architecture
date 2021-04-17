import 'package:flutter/material.dart';

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
