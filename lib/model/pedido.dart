import 'package:t4_1/model/producto.dart';

class Pedido {
  final String id;
  final String mesa;
  final List<Producto> productos;

  Pedido({required this.id, required this.mesa, required this.productos});

  double get total => productos.fold(0, (sum, item) => sum + (item.precio * item.cantidad));
  
  int get numeroProductos => productos.fold(0, (sum, item) => sum + item.cantidad);
}