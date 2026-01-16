import 'package:flutter/material.dart';
import 'package:t4_1/view/home_page.dart';
import 'package:t4_1/view/resumen.dart';
import 'package:t4_1/ui/app_theme.dart';

/// Punto de entrada principal de la aplicación Bar Vader.
/// 
/// Configura el tema y las rutas iniciales.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar Vader',
      theme: AppTheme.themeData(),
      home: const HomePage(),
      routes: {
        '/resumen': (context) => const Resumen(),
      },
    );
  }
}