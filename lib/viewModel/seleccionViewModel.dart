import 'package:flutter/material.dart';
import 'package:t4_1/model/producto.dart';
import 'package:t4_1/model/productoPedido.dart';


class SeleccionViewModel extends ChangeNotifier { 
  final Map<String, int> _selectedQuantities = {};

  final List<Producto> menu = [
    Producto(id: "1", nombre: "Caña", precio: 1.5),
    Producto(id: "2", nombre: "Pinta", precio: 3.0),
    Producto(id: "3", nombre: "Vino Tinto", precio: 2.5),
    Producto(id: "4", nombre: "Refresco", precio: 2.0),
    Producto(id: "5", nombre: "Tapa Bravas", precio: 4.5),
    Producto(id: "6", nombre: "Hamburguesa", precio: 8.0),
    Producto(id: "7", nombre: "Café", precio: 1.2),
  ];

  int getQuantity(String productId) => _selectedQuantities[productId] ?? 0;

  void incrementQuantity(String productId) {
    int current = getQuantity(productId);
    _selectedQuantities[productId] = current + 1;
    notifyListeners();
  }

  void decrementQuantity(String productId) {
    int current = getQuantity(productId);
    if (current > 0) {
      _selectedQuantities[productId] = current - 1;
      notifyListeners();
    }
  }

  List<ProductoPedido> getSelectedItems() {
    return _selectedQuantities.entries
        .where((entry) => entry.value > 0)
        .map((entry) {
          final product = menu.firstWhere((p) => p.id == entry.key);
          return ProductoPedido(product: product, quantity: entry.value);
        })
        .toList();
  }
}