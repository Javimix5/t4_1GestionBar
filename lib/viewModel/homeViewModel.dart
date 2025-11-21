class HomeViewModel extends ChangeNotifier {
  // Lista de pedidos actuales
  List<Pedido> _orders = [];
  List<Pedido> get orders => _orders;

  HomeViewModel() {
    _loadInitialOrders();
  }

  // Carga inicial de pedidos
  void _loadInitialOrders() {
    _orders = [
      Pedido(
        id: '1',
        tableName: 'Mesa 5',
        items: [ProductoPedido(product: _allProducts[0], quantity: 2)],
        totalProducts: 2,
        totalPrice: _allProducts[0].price * 2,
      ),
      Pedido(
        id: '2',
        tableName: 'Encargo Juan',
        items: [
          ProductoPedido(product: _allProducts[2], quantity: 1),
          ProductoPedido(product: _allProducts[5], quantity: 3),
        ],
        totalProducts: 4,
        totalPrice: _allProducts[2].price * 1 + _allProducts[5].price * 3,
      ),
    ];
    // Notifica a las Vistas que la lista ha cambiado
    notifyListeners();
  }

  // Añade un nuevo pedido a la lista
  void addOrder(Pedido newOrder) {
    _orders.insert(0, newOrder);
    notifyListeners();
  }

  // Menú completo de productos (datos simulados)
  static final List<Producto> _allProducts = [
    Producto(id: 'p1', name: 'Café Espresso', price: 1.50),
    Producto(id: 'p2', name: 'Cerveza Lager (33cl)', price: 2.80),
    Producto(id: 'p3', name: 'Vino Tinto (Copa)', price: 3.50),
    Producto(id: 'p4', name: 'Refresco Cola', price: 2.50),
    Producto(id: 'p5', name: 'Bocadillo Jamón', price: 4.90),
    Producto(id: 'p6', name: 'Tarta de Queso', price: 3.95),
    Producto(id: 'p7', name: 'Agua Mineral', price: 1.20),
  ];
}