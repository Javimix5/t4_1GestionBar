import 'package:flutter/material.dart';

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
