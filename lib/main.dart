import 'package:flutter/material.dart';
import 'package:t4_1/view/homeView.dart';
import 'package:t4_1/viewModel/homeViewModel.dart';

void main() {
final homeViewModel = HomeViewModel();
  runApp(BarApp(homeViewModel: homeViewModel));
}

class BarApp extends StatelessWidget {
  final HomeViewModel homeViewModel;
  const BarApp({super.key, required this.homeViewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar Order App (MVVM)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      // Pantalla principal
      home: HomeView(viewModel: homeViewModel),
      
      // Definición de la ruta con nombre para el resumen
      routes: {
        OrderSummaryView.routeName: (context) {
          final order = ModalRoute.of(context)!.settings.arguments as Order;
          return OrderSummaryView(order: order);
        },
      },
    );
  }
}
