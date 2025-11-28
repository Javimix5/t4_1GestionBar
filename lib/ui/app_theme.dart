import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
      primarySwatch: Colors.indigo,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
          textStyle: const TextStyle(fontSize: 14),
          minimumSize: const Size(0, 36),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          textStyle: const TextStyle(fontSize: 14),
          minimumSize: const Size(0, 36),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          textStyle: const TextStyle(fontSize: 13),
          minimumSize: const Size(0, 36),
        ),
      ),
    );
  }

  static ButtonStyle confirmButton(Color color) => ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 8),
        textStyle: const TextStyle(fontSize: 13),
        minimumSize: const Size(0, 36),
      );

  static ButtonStyle smallTextButton({Color? bg, Color? fg}) => TextButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        textStyle: const TextStyle(fontSize: 14),
        minimumSize: const Size(0, 36),
      );

  static ButtonStyle actionOutlined({Color? fg}) => OutlinedButton.styleFrom(
        foregroundColor: fg,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        textStyle: const TextStyle(fontSize: 13),
        minimumSize: const Size(0, 36),
      );

  static const Duration snackBarDuration = Duration(seconds: 1);

  static Widget backgroundLogo({String asset = 'assets/images/logo.png', double opacity = 0.08}) {
    return Positioned.fill(
      child: Image.asset(
        asset,
        fit: BoxFit.cover,
        color: Color.fromRGBO(0, 0, 0, opacity),
        colorBlendMode: BlendMode.darken,
        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}
