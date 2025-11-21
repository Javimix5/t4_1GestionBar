class HomePage extends StatefulWidget { // Renombrado de HomeView
  final HomeViewModel viewModel;
  const HomePage({super.key, required this.viewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Necesario para desuscribirse de ChangeNotifier
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChange);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChange);
    super.dispose();
  }

  void _onViewModelChange() {
    // Reconstruye la vista cuando el ViewModel notifica cambios (ej. se añade un pedido)
    if (mounted) {
      setState(() {});
    }
  }

  // Navegación a la pantalla de creación de pedido
  Future<void> _createNewOrder() async {
    final createViewModel = PedidoViewModel();
    // Navegación imperativa con push, esperando el resultado (Pedido)
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HacerPedido(viewModel: createViewModel),
      ),
    );

    // 1. Verificación de "mounted"
    if (!mounted) return;

    if (result != null && result is Pedido) {
      // 2. Si se devolvió un pedido (no se canceló), se añade a la lista
      widget.viewModel.addOrder(result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pedido "${result.tableName}" guardado con éxito.')),
      );
    }
    // Si es null, el usuario canceló, no se hace nada.
  }

  @override
  Widget build(BuildContext context) {
    final orders = widget.viewModel.orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bar Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: orders.isEmpty
          ? const Center(child: Text('No hay pedidos activos.'))
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey.shade200,
                      child: Text('${index + 1}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey.shade900)),
                    ),
                    title: Text(
                      '${order.tableName}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      '${order.totalProducts} productos',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade400),
                      ),
                      child: Text(
                        '€${order.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    onTap: () {
                      // Opcional: ver detalles del pedido
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createNewOrder,
        icon: const Icon(Icons.local_dining),
        label: const Text('Nuevo Pedido'),
        backgroundColor: Colors.blueGrey.shade700,
        foregroundColor: Colors.white,
      ),
    );
  }
}