import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/config/theme/theme.dart';

final customTheme = ThemeData(
  primaryColor: PRIMARY_COLOR,
  brightness: Brightness.dark,
  accentColor: PRIMARY_COLOR,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: PRIMARY_COLOR,
    ),
  ),
);
