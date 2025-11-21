void main() {
  // Inicializamos el ViewModel principal y se lo pasamos a la aplicación
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
      home: HomePage(viewModel: homeViewModel),
      
      // Definición de la ruta con nombre para el resumen
      routes: {
        Resumen.routeName: (context) {
          final order = ModalRoute.of(context)!.settings.arguments as Pedido;
          return Resumen(order: order);
        },
      },
    );
  }
}