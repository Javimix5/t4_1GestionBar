class SeleccionProductos extends StatefulWidget { // Renombrado de SelectProductsView
  final SeleccionViewModel viewModel;

  const SeleccionProductos({super.key, required this.viewModel});

  @override
  State<SeleccionProductos> createState() => _SeleccionProductosState();
}

class _SeleccionProductosState extends State<SeleccionProductos> {
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
    // Reconstruye la vista cuando el ViewModel notifica cambios
    if (mounted) {
      setState(() {});
    }
  }

  void _confirmSelection() {
    // Devuelve la lista de ProductoPedido seleccionados
    Navigator.pop(context, widget.viewModel.getSelectedItems());
  }

  void _cancelSelection() {
    // Cierra la pantalla sin devolver datos
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;
    final totalSelected = viewModel.getSelectedItems().length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selección de Productos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlue.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: viewModel.menu.length,
        itemBuilder: (context, index) {
          final product = viewModel.menu[index];
          final quantity = viewModel.getQuantity(product.id);
          final isSelected = quantity > 0;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: isSelected ? 4 : 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: isSelected ? BorderSide(color: Colors.lightBlue.shade400, width: 2) : BorderSide.none,
            ),
            child: ListTile(
              title: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.lightBlue.shade800 : Colors.black87)),
              subtitle: Text('€${product.price.toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botón para decrementar cantidad
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline, color: quantity > 0 ? Colors.red : Colors.grey),
                    onPressed: quantity > 0 ? () => viewModel.decrementQuantity(product.id) : null,
                  ),
                  // Muestra la cantidad actual
                  SizedBox(
                    width: 30,
                    child: Text(
                      '$quantity',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Botón para incrementar cantidad
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, color: Colors.lightBlue.shade700),
                    onPressed: () => viewModel.incrementQuantity(product.id),
                  ),
                ],
              ),
              onTap: () {
                // Alternar selección o incrementar si no está seleccionado
                if (quantity == 0) {
                  viewModel.incrementQuantity(product.id);
                }
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _cancelSelection,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  side: const BorderSide(color: Colors.red),
                ),
                child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: totalSelected > 0 ? _confirmSelection : null,
                icon: const Icon(Icons.check, size: 20),
                label: Text('Confirmar ($totalSelected items)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}