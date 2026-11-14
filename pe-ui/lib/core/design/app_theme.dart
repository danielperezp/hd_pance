import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const Color _seed = Color(0xFF1B7F5C);

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: brightness),
    useMaterial3: true,
  );
}
