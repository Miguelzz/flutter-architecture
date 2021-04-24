import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/common/components/box.dart';

class H1 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;

  H1(this.text, {this.color, this.child, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Box(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child: Text(text,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w600, color: color)),
    );
  }
}

class H2 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;

  H2(this.text, {this.color, this.child, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Box(
      margin: EdgeInsets.only(bottom: 8, top: 8),
      child: Text(text,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.w600, color: color)),
    );
  }
}

class H3 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;

  H3(this.text, {this.color, this.child, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Box(
      margin: EdgeInsets.only(bottom: 5),
      child: Text(text,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: color)),
    );
  }
}

class H4 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;

  H4(this.text, {this.color, this.child, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Box(
      margin: EdgeInsets.only(bottom: 5),
      child: Text(text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: color,
          )),
    );
  }
}

class H5 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;

  H5(this.text, {this.color, this.child, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Box(
      margin: EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style:
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }
}

class P extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;

  P(this.text, {this.color, this.child, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Box(
      margin: EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(color: color),
      ),
    );
  }
}
