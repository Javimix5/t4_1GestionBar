import 'package:flutter/material.dart';
import 'package:t4_1/model/producto.dart';

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
          Positioned.fill(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              color: Color.fromRGBO(0,0,0,0.08),
              colorBlendMode: BlendMode.darken,
              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
            ),
          ),
          ListView.builder(
            itemCount: _carta.length,
            itemBuilder: (context, index) {
              final producto = _carta[index];
              final cantidad = _cantidades[index] ?? 0;
              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      producto.image ?? '',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => CircleAvatar(child: Text(producto.nombre[0])),
                    ),
                  ),
                  title: Text(producto.nombre),
                  subtitle: Text("${producto.precio} €"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _decrementar(index),
                        icon: const Icon(Icons.remove_circle_outline),
                        iconSize: 20,
                        padding: const EdgeInsets.all(6),
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 6),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            "$cantidad",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        onPressed: () => _incrementar(index),
                        icon: const Icon(Icons.add_circle, color: Colors.blue),
                        iconSize: 20,
                        padding: const EdgeInsets.all(6),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              child: TextButton(
                style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), textStyle: const TextStyle(fontSize: 14), minimumSize: const Size(0, 36)),
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 8), textStyle: const TextStyle(fontSize: 14), minimumSize: const Size(0, 36)),
                onPressed: _confirmar,
                child: const Text("Confirmar Selección"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
