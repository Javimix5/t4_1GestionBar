import 'package:flutter/material.dart';
import 'package:t4_1/model/producto.dart';
import 'package:t4_1/ui/app_theme.dart';
import 'package:t4_1/components/widgets/product_list_item.dart';
import 'package:t4_1/components/widgets/bottom_action_bar.dart';

class SeleccionProductos extends StatefulWidget {
  final List<Producto>? initialSelected;

  const SeleccionProductos({super.key, this.initialSelected});

  @override
  State<SeleccionProductos> createState() => _SeleccionProductosState();
}

class _SeleccionProductosState extends State<SeleccionProductos> {
  final List<Producto> _carta = [
    Producto(id: "1", nombre: "Caña", precio: 1.5, image: 'assets/images/cana.png'),
    Producto(id: "2", nombre: "Pinta", precio: 3.0, image: 'assets/images/pinta.png'),
    Producto(id: "3", nombre: "Vino Tinto", precio: 2.5, image: 'assets/images/vino.png'),
    Producto(id: "4", nombre: "Refresco", precio: 2.0, image: 'assets/images/refresco.png'),
    Producto(id: "5", nombre: "Tapa Bravas", precio: 4.5, image: 'assets/images/bravas.png'),
    Producto(id: "6", nombre: "Hamburguesa", precio: 8.0, image: 'assets/images/hamburguesa.png'),
    Producto(id: "7", nombre: "Café", precio: 1.2, image: 'assets/images/cafe.png'),
  ];

  final Map<int, int> _cantidades = {};

  @override
  void initState() {
    super.initState();
    if (widget.initialSelected != null && widget.initialSelected!.isNotEmpty) {
      for (var sel in widget.initialSelected!) {
        final idx = _carta.indexWhere((p) => p.id == sel.id);
        if (idx != -1) {
          _cantidades[idx] = sel.cantidad;
        }
      }
    }
  }

  void _incrementar(int index) {
    setState(() {
      _cantidades[index] = (_cantidades[index] ?? 0) + 1;
    });
  }

  void _decrementar(int index) {
    setState(() {
      int actual = _cantidades[index] ?? 0;
      if (actual > 0) {
        _cantidades[index] = actual - 1;
      }
    });
  }

  void _confirmar() {
    List<Producto> seleccionados = [];
    _cantidades.forEach((index, cantidad) {
      if (cantidad > 0) {
        var prod = _carta[index].copy();
        prod.cantidad = cantidad;
        seleccionados.add(prod);
      }
    });
    Navigator.pop(context, seleccionados);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seleccionar Productos")),
      body: Stack(
        children: [
          AppTheme.backgroundLogo(),
          ListView.builder(
            itemCount: _carta.length,
            itemBuilder: (context, index) {
              final producto = _carta[index];
              final cantidad = _cantidades[index] ?? 0;
              return ProductListItem(
                producto: producto,
                cantidad: cantidad,
                onIncrement: () => _incrementar(index),
                onDecrement: () => _decrementar(index),
                showPrice: false,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomActionBar(
        children: [
          SizedBox(
            width: 120,
            child: TextButton(
              style: AppTheme.smallTextButton(),
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 140,
            child: OutlinedButton(
              onPressed: _confirmar,
              child: const Text("Confirmar Selección"),
            ),
          ),
        ],
      ),
    );
  }
}
