import 'package:flutter/material.dart';

const Color PRIMARY_COLOR = Colors.red;
const Color ACCENT_COLOR = Colors.white;

class SelectTheme {
  ValueGetter<Future<void>> light;
  ValueGetter<Future<void>> dark;
  ValueGetter<Future<void>> custom;

  SelectTheme(this.light, this.dark, this.custom);
}
