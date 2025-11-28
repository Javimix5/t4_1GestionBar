import 'package:flutter/material.dart';
import 'package:t4_1/view/homePage.dart';
import 'package:t4_1/view/resumen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar Vader',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
      routes: {
        '/resumen': (context) => const Resumen(),
      },
    );
  }
}