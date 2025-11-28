import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/model/producto.dart';

class HomeViewModel extends ChangeNotifier {
  List<Pedido> pedidos = [];

  HomeViewModel() {
    _cargarDatosIniciales();
  }

  void _cargarDatosIniciales() {
    pedidos = [
      Pedido(
        id: 'p1',
        mesa: 'Mesa 1',
        productos: [
          Producto(id: '1', nombre: 'Caña', precio: 1.5, cantidad: 2, image: 'assets/images/cana.png'),
          Producto(id: '5', nombre: 'Tapa Bravas', precio: 4.5, cantidad: 1, image: 'assets/images/bravas.png'),
        ],
      ),
      Pedido(
        id: 'p2',
        mesa: 'Mesa 2',
        productos: [
          Producto(id: '2', nombre: 'Pinta', precio: 3.0, cantidad: 1, image: 'assets/images/pinta.png'),
          Producto(id: '6', nombre: 'Hamburguesa', precio: 8.0, cantidad: 2, image: 'assets/images/hamburguesa.png'),
        ],
      ),
    ];
    notifyListeners();
  }

  void agregarPedido(Pedido pedido) {
    pedidos.add(pedido);
    notifyListeners();
  }

  void actualizarPedidoById(String id, Pedido pedido) {
    final idx = pedidos.indexWhere((p) => p.id == id);
    if (idx != -1) {
      pedidos[idx] = pedido;
      notifyListeners();
    }
  }

  void eliminarPedidoById(String id) {
    final idx = pedidos.indexWhere((p) => p.id == id);
    if (idx != -1) {
      pedidos.removeAt(idx);
      notifyListeners();
    }
  }
}
