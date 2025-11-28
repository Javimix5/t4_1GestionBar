// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:t4_1/main.dart';

void main() {
  testWidgets('App launches and opens Nuevo Pedido page', (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(const MyApp());

    // Home should show the app bar title
    expect(find.text('Pedidos del Bar'), findsOneWidget);

    // FAB with add icon should be present
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the FAB to open the Nuevo Pedido screen
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // New screen should show 'Nuevo Pedido' title and the mesa input
    expect(find.text('Nuevo Pedido'), findsOneWidget);
    expect(find.text('Mesa / Identificador'), findsOneWidget);
  });
}
