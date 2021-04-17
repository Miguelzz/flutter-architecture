import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';

final darkTheme = ThemeData(
  primaryColor: PRIMARY_COLOR,
  brightness: Brightness.dark,
  accentColor: ACCENT_COLOR,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: PRIMARY_COLOR,
    ),
  ),
);
