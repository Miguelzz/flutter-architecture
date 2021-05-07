import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/modules/global_widgets/box.dart';

class Font extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final FontWeight? fontWeight;

  Font(
    this.text, {
    this.color,
    this.child,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Box(
      margin: margin ?? EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}

class H1 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;
  final EdgeInsetsGeometry? margin;

  H1(this.text, {this.color, this.child, this.textAlign, this.margin});

  @override
  Widget build(BuildContext context) {
    return Font(
      text,
      child: child,
      color: color,
      textAlign: textAlign,
      margin: margin,
      fontSize: Theme.of(context).textTheme.headline1?.fontSize,
    );
  }
}

class H2 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;
  final EdgeInsetsGeometry? margin;

  H2(this.text, {this.color, this.child, this.textAlign, this.margin});

  @override
  Widget build(BuildContext context) {
    return Font(
      text,
      child: child,
      color: color,
      textAlign: textAlign,
      margin: margin,
      fontSize: Theme.of(context).textTheme.headline2?.fontSize,
    );
  }
}

class H3 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;
  final EdgeInsetsGeometry? margin;

  H3(this.text, {this.color, this.child, this.textAlign, this.margin});

  @override
  Widget build(BuildContext context) {
    return Font(
      text,
      child: child,
      color: color,
      textAlign: textAlign,
      margin: margin,
      fontSize: Theme.of(context).textTheme.headline3?.fontSize,
    );
  }
}

class H4 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;
  final EdgeInsetsGeometry? margin;

  H4(this.text, {this.color, this.child, this.textAlign, this.margin});

  @override
  Widget build(BuildContext context) {
    return Font(
      text,
      child: child,
      color: color,
      textAlign: textAlign,
      margin: margin,
      fontSize: Theme.of(context).textTheme.headline4?.fontSize,
    );
  }
}

class H5 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;
  final EdgeInsetsGeometry? margin;

  H5(this.text, {this.color, this.child, this.textAlign, this.margin});

  @override
  Widget build(BuildContext context) {
    return Font(
      text,
      child: child,
      color: color,
      textAlign: textAlign,
      margin: margin,
      fontSize: Theme.of(context).textTheme.headline5?.fontSize,
    );
  }
}

class H6 extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;
  final EdgeInsetsGeometry? margin;

  H6(this.text, {this.color, this.child, this.textAlign, this.margin});

  @override
  Widget build(BuildContext context) {
    return Font(
      text,
      child: child,
      color: color,
      textAlign: textAlign,
      margin: margin,
      fontSize: Theme.of(context).textTheme.headline6?.fontSize,
    );
  }
}

class P extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final TextAlign? textAlign;
  final String text;
  final EdgeInsetsGeometry? margin;

  P(this.text, {this.color, this.child, this.textAlign, this.margin});

  @override
  Widget build(BuildContext context) {
    return Font(
      text,
      child: child,
      color: color,
      textAlign: textAlign,
      margin: margin,
      fontSize: Theme.of(context).textTheme.bodyText1?.fontSize,
    );
  }
}
