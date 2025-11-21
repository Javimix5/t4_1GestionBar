class ProductoPedido { // Renombrado de OrderItem
  final Producto product;
  int quantity;

  ProductoPedido({required this.product, required this.quantity});

  // Calcula el precio total de este artículo
  double get total => product.price * quantity;
}