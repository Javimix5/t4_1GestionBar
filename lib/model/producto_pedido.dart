import 'package:t4_1/model/producto.dart';

class ProductoPedido {
  final Producto product;
  int quantity;

  ProductoPedido({required this.product, required this.quantity});

  double get total => product.precio * quantity;
}
