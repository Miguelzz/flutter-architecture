import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';

final lightTheme = ThemeData(
  primaryColor: PRIMARY_COLOR,
  brightness: Brightness.light,
  accentColor: ACCENT_COLOR,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: PRIMARY_COLOR,
    ),
  ),
);
