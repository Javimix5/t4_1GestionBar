class Pedido { // Renombrado de Order
  final String id;
  final String tableName;
  final List<ProductoPedido> items;
  final int totalProducts;
  final double totalPrice;

  Pedido({
    required this.id,
    required this.tableName,
    required this.items,
    required this.totalProducts,
    required this.totalPrice,
  });

  // Método de utilidad para crear un pedido a partir de un nombre y una lista de items
  static Pedido fromItems(String tableName, List<ProductoPedido> items) {
    int totalProducts = items.fold(0, (sum, item) => sum + item.quantity);
    double totalPrice = items.fold(0.0, (sum, item) => sum + item.total);

    return Pedido(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      tableName: tableName,
      items: items,
      totalProducts: totalProducts,
      totalPrice: totalPrice,
    );
  }
}