import 'package:flutter/material.dart';

/// Widget que representa una barra de acciones en la parte inferior de la pantalla.
/// 
/// Permite agregar múltiples widgets como acciones.
/// 
/// Ejemplo de uso:
/// ```dart
/// BottomActionBar(
///   children: [
///    ElevatedButton(onPressed: () {}, child: Text('Aceptar')),
///   OutlinedButton(onPressed: () {}, child: Text('Cancelar')),
/// ],
/// );
/// ```

class BottomActionBar extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;

  const BottomActionBar({super.key, required this.children, this.padding = const EdgeInsets.all(8.0)});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
