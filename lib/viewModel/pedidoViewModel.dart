class PedidoViewModel extends ChangeNotifier { // Renombrado de CreateOrderViewModel
  String _tableName = '';
  List<ProductoPedido> _selectedItems = [];

  String get tableName => _tableName;
  List<ProductoPedido> get selectedItems => _selectedItems;

  // Propiedad calculada: número total de productos
  int get totalProducts => _selectedItems.fold(0, (sum, item) => sum + item.quantity);

  // Propiedad calculada: precio total del pedido
  double get totalPrice => _selectedItems.fold(0.0, (sum, item) => sum + item.total);

  // Validación: verdadero si el nombre de la mesa/pedido no está vacío y hay productos seleccionados
  bool get isValid => _tableName.isNotEmpty && _selectedItems.isNotEmpty;

  // Actualiza el nombre de la mesa/pedido
  void updateTableName(String name) {
    _tableName = name.trim();
    notifyListeners();
  }

  // Actualiza la lista de productos seleccionados
  void updateSelectedItems(List<ProductoPedido> items) {
    _selectedItems = items;
    notifyListeners();
  }

  // Genera el objeto Order completo para devolver a la pantalla Home
  Pedido generateOrder() {
    return Pedido.fromItems(_tableName, _selectedItems);
  }
}