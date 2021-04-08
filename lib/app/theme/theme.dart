import 'package:flutter/material.dart';
import 'package:group/app/theme/colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    buttonColor: buttonColor,
    brightness: Brightness.light,
    accentColor: accentColor,
    buttonTheme: ButtonThemeData(
      buttonColor: buttonColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: primaryColor,
    buttonColor: buttonColor,
    brightness: Brightness.dark,
    accentColor: accentColor,
  );

  static final customTheme = ThemeData(
    primaryColor: primaryColor,
    buttonColor: buttonColor,
    brightness: Brightness.dark,
    accentColor: accentColor,
  );
}

class SelectTheme {
  ValueGetter<Future<void>> light;
  ValueGetter<Future<void>> dark;
  ValueGetter<Future<void>> custom;

  SelectTheme(this.light, this.dark, this.custom);
}
