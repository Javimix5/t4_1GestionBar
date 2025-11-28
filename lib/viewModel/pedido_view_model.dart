import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/model/producto.dart';

class PedidoViewModel extends ChangeNotifier {
  String mesa = "";
  String? id;
  List<Producto> productosSeleccionados = [];

  void setMesa(String nombre) {
    mesa = nombre;
    notifyListeners();
  }

  void setId(String newId) {
    id = newId;
  }

  void actualizarProductos(List<Producto> nuevosProductos) {
    productosSeleccionados = nuevosProductos;
    notifyListeners();
  }

  double get total => productosSeleccionados.fold(0, (sum, item) => sum + (item.precio * item.cantidad));

  bool esValido() {
    return mesa.isNotEmpty && productosSeleccionados.isNotEmpty;
  }
  
  Pedido generarPedido() {
    final idToUse = id ?? DateTime.now().millisecondsSinceEpoch.toString();
    return Pedido(id: idToUse, mesa: mesa, productos: productosSeleccionados);
  }
}
