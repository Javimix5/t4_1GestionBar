import 'package:t4_1/model/producto.dart';

class ProductoPedido {
  Producto ? producto;
  int cantidad;

  ProductoPedido({required this.producto, required this.cantidad});

  double get total => producto!.precio! * cantidad;
}