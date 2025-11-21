class SeleccionViewModel extends ChangeNotifier { // Renombrado de SelectProductsViewModel
  // Mapa para rastrear las cantidades seleccionadas. Key: Product ID, Value: Quantity
  Map<String, int> _selectedQuantities = {};

  final List<Producto> menu = HomeViewModel._allProducts;

  // Obtiene la cantidad de un producto específico
  int getQuantity(String productId) => _selectedQuantities[productId] ?? 0;

  // Incrementa la cantidad del producto
  void incrementQuantity(String productId) {
    int current = getQuantity(productId);
    _selectedQuantities[productId] = current + 1;
    notifyListeners();
  }

  // Decrementa la cantidad del producto (mínimo 0)
  void decrementQuantity(String productId) {
    int current = getQuantity(productId);
    if (current > 0) {
      _selectedQuantities[productId] = current - 1;
      notifyListeners();
    }
  }

  // Genera la lista final de OrderItem para devolver
  List<ProductoPedido> getSelectedItems() {
    return _selectedQuantities.entries
        .where((entry) => entry.value > 0)
        .map((entry) {
          final product = menu.firstWhere((p) => p.id == entry.key);
          return ProductoPedido(product: product, quantity: entry.value);
        })
        .toList();
  }
}