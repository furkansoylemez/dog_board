import 'package:flutter/material.dart';

class AppTheme {
  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(centerTitle: true),
      colorSchemeSeed: Colors.orangeAccent,
    );
  }
}
