import 'package:flutter/material.dart';

const Color PRIMARY_COLOR = Colors.redAccent;
const Color BUTTON_COLOR = Colors.redAccent;
const Color ACCENT_COLOR = Colors.redAccent;

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: PRIMARY_COLOR,
    buttonColor: BUTTON_COLOR,
    brightness: Brightness.light,
    accentColor: ACCENT_COLOR,
    buttonTheme: ButtonThemeData(
      buttonColor: BUTTON_COLOR,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: PRIMARY_COLOR,
    buttonColor: BUTTON_COLOR,
    brightness: Brightness.dark,
    accentColor: ACCENT_COLOR,
  );

  static final customTheme = ThemeData(
    primaryColor: PRIMARY_COLOR,
    buttonColor: BUTTON_COLOR,
    brightness: Brightness.dark,
    accentColor: ACCENT_COLOR,
  );
}

class SelectTheme {
  ValueGetter<Future<void>> light;
  ValueGetter<Future<void>> dark;
  ValueGetter<Future<void>> custom;

  SelectTheme(this.light, this.dark, this.custom);
}
