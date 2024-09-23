import 'package:flutter/material.dart';

import 'color_manager.dart';

ThemeData getApplicationThemeData() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManager.primary,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
    ),
  );
}
