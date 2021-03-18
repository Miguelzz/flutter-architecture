import 'package:flutter/material.dart';

class Theme {
  static final lightTheme = ThemeData(
    primaryColor: Colors.redAccent,
    buttonColor: Colors.redAccent,
    brightness: Brightness.light,
    accentColor: Colors.redAccent,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.redAccent,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.redAccent,
    buttonColor: Colors.redAccent,
    brightness: Brightness.dark,
    accentColor: Colors.redAccent,
  );

  static final debtorTheme = ThemeData(
    primaryColor: Colors.redAccent,
    buttonColor: Colors.redAccent,
    brightness: Brightness.dark,
    accentColor: Colors.redAccent,
  );
}
