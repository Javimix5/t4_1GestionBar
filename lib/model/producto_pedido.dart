import 'package:t4_1/model/producto.dart';

/// Modelo que representa un producto en un pedido, incluyendo el producto en sí y la cantidad solicitada.
/// Contiene un objeto Producto y un entero quantity.
/// También proporciona un método para calcular el total basado en la cantidad.
class ProductoPedido {
  final Producto product;
  int quantity;

  ProductoPedido({required this.product, required this.quantity});

  double get total => product.precio * quantity;
}
