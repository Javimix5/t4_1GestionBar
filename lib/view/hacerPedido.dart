class HacerPedido extends StatefulWidget { // Renombrado de CreateOrderView
  final PedidoViewModel viewModel;

  const HacerPedido({super.key, required this.viewModel});

  @override
  State<HacerPedido> createState() => _HacerPedidoState();
}

class _HacerPedidoState extends State<HacerPedido> {
  final TextEditingController _nameController = TextEditingController();
  late final SeleccionViewModel _selectProductsViewModel;

  @override
  void initState() {
    super.initState();
    // Inicializa el ViewModel de selección de productos
    _selectProductsViewModel = SeleccionViewModel();
    // Escucha el ViewModel del pedido para reconstruir cuando cambie
    widget.viewModel.addListener(_onViewModelChange);
    // Inicializa el campo de texto con el valor actual del ViewModel
    _nameController.text = widget.viewModel.tableName;
    _nameController.addListener(() {
      widget.viewModel.updateTableName(_nameController.text);
    });
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChange);
    _nameController.dispose();
    super.dispose();
  }

  void _onViewModelChange() {
    if (mounted) {
      setState(() {});
    }
  }

  // Navegación a la selección de productos
  Future<void> _navigateToProductSelection() async {
    // Navegación imperativa con push, esperando el resultado (List<ProductoPedido>)
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeleccionProductos(viewModel: _selectProductsViewModel),
      ),
    );

    // 1. Verificación de "mounted"
    if (!mounted) return;

    if (result != null && result is List<ProductoPedido>) {
      // 2. Si se devolvieron datos, actualizar el ViewModel
      widget.viewModel.updateSelectedItems(result);
      // Opcionalmente, restablecer el ViewModel de selección para el próximo uso si fuera necesario,
      // pero en este caso, se asume que cada pedido comienza con una nueva selección.
    }
    // Si es null, el usuario canceló, no se hace nada.
  }

  // Navegación al resumen final (ruta con nombre)
  void _navigateToSummary() {
    if (widget.viewModel.isValid) {
      final orderPreview = widget.viewModel.generateOrder();
      // Navegación con ruta con nombre (pushNamed)
      Navigator.pushNamed(
        context,
        Resumen.routeName,
        arguments: orderPreview,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: El pedido debe tener un nombre/mesa y al menos un producto.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Guardar y devolver el pedido
  void _saveOrder() {
    if (widget.viewModel.isValid) {
      final completeOrder = widget.viewModel.generateOrder();
      // pop(context, resultado) para devolver el pedido a Home
      Navigator.pop(context, completeOrder);
    } else {
      // Validación: Muestra mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Debes introducir un nombre/mesa y añadir productos para guardar.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Cancelar
  void _cancelOrder() {
    // pop(context) sin devolver resultado
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Nuevo Pedido', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de texto para Mesa / Nombre
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Mesa o Nombre del Pedido',
                hintText: 'Ej: Mesa 7',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.person_pin_circle),
              ),
            ),
            const SizedBox(height: 20),

            // Botón para añadir productos
            ElevatedButton.icon(
              onPressed: _navigateToProductSelection,
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Añadir Productos a la Carta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade400,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 30),

            // Resumen Provisional del Pedido
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resumen Provisional',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.orange.shade700),
                    ),
                    const Divider(),
                    Text('Nombre: ${viewModel.tableName.isEmpty ? 'Sin Nombre' : viewModel.tableName}'),
                    const SizedBox(height: 8),
                    Text('Productos Seleccionados: ${viewModel.totalProducts}'),
                    const SizedBox(height: 8),
                    Text(
                      'Total Acumulado: €${viewModel.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Lista de productos seleccionados
                    ...viewModel.selectedItems.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text('${item.quantity}x ${item.product.name} (€${item.total.toStringAsFixed(2)})', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                        )).toList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Botón para Ver Resumen (Navegación con ruta con nombre)
            OutlinedButton.icon(
              onPressed: viewModel.isValid ? _navigateToSummary : null,
              icon: const Icon(Icons.receipt),
              label: const Text('Ver Resumen Final'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                side: BorderSide(color: Colors.deepOrange.shade200),
                foregroundColor: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _cancelOrder,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: viewModel.isValid ? _saveOrder : null,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Pedido'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
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