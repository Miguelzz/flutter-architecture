import 'package:flutter/material.dart';

class AppTheme {
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

  static final personalizedTheme = ThemeData(
    primaryColor: Colors.redAccent,
    buttonColor: Colors.redAccent,
    brightness: Brightness.dark,
    accentColor: Colors.redAccent,
  );
}

class SelectTheme {
  ValueGetter<Future<void>> light;
  ValueGetter<Future<void>> dark;
  ValueGetter<Future<void>> personalized;

  SelectTheme(this.light, this.dark, this.personalized);
}