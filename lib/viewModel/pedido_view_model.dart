import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/model/producto.dart';

/// ViewModel para la gestión de un pedido.
class PedidoViewModel extends ChangeNotifier {
  String mesa = "";
  String? id;
  List<Producto> productosSeleccionados = [];

/// Actualiza el nombre de la mesa y notifica a los oyentes.
  void setMesa(String nombre) {
    mesa = nombre;
    notifyListeners();
  }

  void setId(String newId) {
    id = newId;
  }

/// Actualiza la lista de productos seleccionados y notifica a los oyentes.
  void actualizarProductos(List<Producto> nuevosProductos) {
    productosSeleccionados = nuevosProductos;
    notifyListeners();
  }

  double get total => productosSeleccionados.fold(0, (sum, item) => sum + (item.precio * item.cantidad));

/// Verifica si el pedido es válido (mesa no vacía y al menos un producto seleccionado).
  bool esValido() {
    return mesa.isNotEmpty && productosSeleccionados.isNotEmpty;
  }
  
/// Genera un objeto Pedido basado en el estado actual del ViewModel.
  Pedido generarPedido() {
    final idToUse = id ?? DateTime.now().millisecondsSinceEpoch.toString();
    return Pedido(id: idToUse, mesa: mesa, productos: productosSeleccionados);
  }
}
