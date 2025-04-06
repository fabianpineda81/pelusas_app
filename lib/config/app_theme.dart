import 'package:flutter/material.dart';
class AppTheme {

  static const colorLightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2196F3),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFBBDEFB),
    onPrimaryContainer: Color(0xFF0D47A1),
    secondary: Color(0xFF00BCD4),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFB2EBF2),
    onSecondaryContainer: Color(0xFF004D40),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF212121),
    surfaceTint: Color(0xFF2196F3),
    tertiary: Color(0xFFC5CAE9),
    onTertiary: Color(0xFF1A237E),
    tertiaryContainer: Color(0xFFE8EAF6),
    onTertiaryContainer: Color(0xFF3F51B5),
    error: Color(0xFFF44336),
    onError: Colors.white,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF90CAF9),
    onPrimary: Color(0xFF0D47A1),
    primaryContainer: Color(0xFF1565C0),
    onPrimaryContainer: Colors.white,
    secondary: Color(0xFF80DEEA),
    onSecondary: Color(0xFF004D40),
    secondaryContainer: Color(0xFF006064),
    onSecondaryContainer: Colors.white,
    surface: Color(0xFF131212),
    onSurface: Color(0xFFE0E0E0),
    surfaceTint: Color(0xFF90CAF9),
    tertiary: Color(0xFF9FA8DA),
    onTertiary: Color(0xFF1A237E),
    tertiaryContainer: Color(0xFF3F51B5),
    onTertiaryContainer: Colors.white,
    error: Color(0xFFEF9A9A),
    onError: Colors.black,
  );

  final darkTheme = ThemeData.from(colorScheme: darkColorScheme, useMaterial3: true);

  final bool isDarkMode;

  AppTheme(this.isDarkMode);

  ThemeData getTheme() {
    final colorScheme = isDarkMode ? darkColorScheme : colorLightScheme;

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: colorScheme,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }


}
