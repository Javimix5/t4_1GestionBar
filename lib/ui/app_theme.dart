import 'package:flutter/material.dart';

/// Clase que define el tema de la aplicación, incluyendo estilos para botones,
/// colores primarios y un widget de logo de fondo reutilizable.
/// También proporciona duraciones estándar para SnackBars. Está configurada para ser 
/// breve, mejorando la experiencia del usuario.
/// Además, incluye un widget para mostrar un logo de fondo con opacidad ajustable.
class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
      primarySwatch: Colors.indigo,

      /// Estilos para botones elevados.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
          textStyle: const TextStyle(fontSize: 14),
          minimumSize: const Size(0, 36),
        ),
      ),

      /// Estilos para botones de texto.
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          textStyle: const TextStyle(fontSize: 14),
          minimumSize: const Size(0, 36),
        ),
      ),

      /// Estilos para botones outlined.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          textStyle: const TextStyle(fontSize: 13),
          minimumSize: const Size(0, 36),
        ),
      ),
    );
  }

/// Botón de confirmación con color personalizado.
  static ButtonStyle confirmButton(Color color) => ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 8),
        textStyle: const TextStyle(fontSize: 13),
        minimumSize: const Size(0, 36),
      );

/// Botón de texto pequeño con colores personalizados.
  static ButtonStyle smallTextButton({Color? bg, Color? fg}) => TextButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        textStyle: const TextStyle(fontSize: 14),
        minimumSize: const Size(0, 36),
      );

/// Botón de acción con estilo outlined.
  static ButtonStyle actionOutlined({Color? fg}) => OutlinedButton.styleFrom(
        foregroundColor: fg,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        textStyle: const TextStyle(fontSize: 13),
        minimumSize: const Size(0, 36),
      );

/// Duración estándar para SnackBars.
  static const Duration snackBarDuration = Duration(seconds: 1);

/// Widget que muestra un logo de fondo con opacidad ajustable.
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
