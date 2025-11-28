import 'package:flutter/material.dart';
import 'package:t4_1/model/producto.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/view/seleccion_productos.dart';
import 'package:t4_1/viewModel/pedido_view_model.dart';
import 'package:t4_1/ui/app_theme.dart';

class HacerPedido extends StatefulWidget {
  final Pedido? pedido;

  const HacerPedido({super.key, this.pedido});

  @override
  State<HacerPedido> createState() => _HacerPedidoState();
}

class _HacerPedidoState extends State<HacerPedido> {
  final PedidoViewModel _viewModel = PedidoViewModel();
  final TextEditingController _mesaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mesaController.addListener(() {
      _viewModel.setMesa(_mesaController.text);
    });
    if (widget.pedido != null) {
      _mesaController.text = widget.pedido!.mesa;
      _viewModel.setMesa(widget.pedido!.mesa);
      _viewModel.setId(widget.pedido!.id);
      final copias = widget.pedido!.productos.map((p) => p.copy()).toList();
      _viewModel.actualizarProductos(copias);
    }
  }

  @override
  void dispose() {
    _mesaController.dispose();
    super.dispose();
  }

  Future<void> _irASeleccionarProductos() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeleccionProductos(initialSelected: _viewModel.productosSeleccionados)),
    );

    if (!mounted) return;

    if (result is List<Producto>) {
      _viewModel.actualizarProductos(result);
    }
  }

  void _eliminarProducto(String id) {
    final nueva = List<Producto>.from(_viewModel.productosSeleccionados);
    final prod = nueva.firstWhere((p) => p.id == id, orElse: () => Producto(id: '', nombre: '', precio: 0));
    nueva.removeWhere((p) => p.id == id);
    _viewModel.actualizarProductos(nueva);
    if (mounted && prod.id.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Producto "${prod.nombre}" eliminado'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _decrementarProducto(String id) {
    final idx = _viewModel.productosSeleccionados.indexWhere((p) => p.id == id);
    if (idx == -1) return;
    final nueva = List<Producto>.from(_viewModel.productosSeleccionados);
    final prod = nueva[idx];
    if (prod.cantidad > 1) {
      prod.cantidad -= 1;
      nueva[idx] = prod;
    } else {
      nueva.removeAt(idx);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Producto "${prod.nombre}" eliminado'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    }
    _viewModel.actualizarProductos(nueva);
  }

  void _incrementarProducto(String id) {
    final idx = _viewModel.productosSeleccionados.indexWhere((p) => p.id == id);
    if (idx == -1) return;
    final nueva = List<Producto>.from(_viewModel.productosSeleccionados);
    final prod = nueva[idx];
    prod.cantidad += 1;
    nueva[idx] = prod;
    _viewModel.actualizarProductos(nueva);
  }

  Future<void> _verResumen() async {
    await Navigator.pushNamed(
      context,
      '/resumen',
      arguments: _viewModel.generarPedido(),
    );
    if (!mounted) return;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pedido != null ? 'Editar Pedido' : 'Nuevo Pedido')),
      body: Stack(
        children: [
          // Background logo from AppTheme
          AppTheme.backgroundLogo(),
          ListenableBuilder(
            listenable: _viewModel,
            builder: (context, _) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _mesaController,
                      decoration: const InputDecoration(
                        labelText: "Mesa / Identificador",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.table_bar),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _viewModel.productosSeleccionados.isEmpty
                        ? const Align(
                          alignment: Alignment(0, -1),
                            child: Text(
                              "Ningún producto seleccionado",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _viewModel.productosSeleccionados.length,
                            itemBuilder: (context, index) {
                              final prod = _viewModel.productosSeleccionados[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.asset(
                                        prod.image ?? '',
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => CircleAvatar(child: Text(prod.nombre[0])),
                                      ),
                                    ),
                                    title: Text(prod.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: Text("${prod.precio} €"),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle_outline, color: Colors.orange),
                                          iconSize: 20,
                                          padding: const EdgeInsets.all(6),
                                          constraints: const BoxConstraints(),
                                          onPressed: () => _decrementarProducto(prod.id),
                                        ),
                                        const SizedBox(width: 6),
                                        SizedBox(
                                          width: 36,
                                          child: Center(
                                            child: Text(
                                              "${prod.cantidad}",
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                                                                const SizedBox(width: 6),
                                        IconButton(
                                          icon: const Icon(Icons.add_circle, color: Colors.green),
                                          iconSize: 20,
                                          padding: const EdgeInsets.all(6),
                                          constraints: const BoxConstraints(),
                                          onPressed: () => _incrementarProducto(prod.id),
                                        ),
                                        const SizedBox(width: 6),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          iconSize: 20,
                                          padding: const EdgeInsets.all(6),
                                          constraints: const BoxConstraints(),
                                          onPressed: () => _eliminarProducto(prod.id),
                                        ),
                                        const SizedBox(width: 12),
                                        SizedBox(
                                          width: 88,
                                          child: Text(
                                            "${(prod.precio * prod.cantidad).toStringAsFixed(2)} €",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                            },
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("TOTAL PROVISIONAL:", style: TextStyle(fontSize: 16)),
                            Text(
                              "${_viewModel.total.toStringAsFixed(2)} €",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), textStyle: const TextStyle(fontSize: 13), minimumSize: const Size(0, 36)),
                                onPressed: _irASeleccionarProductos,
                                child: const Text("Añadir Productos"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(vertical: 8), textStyle: const TextStyle(fontSize: 13), minimumSize: const Size(0, 36)),
                                onPressed: _viewModel.productosSeleccionados.isNotEmpty ? _verResumen : null,
                                child: const Text("Ver Resumen"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.pedido != null) ...[
                SizedBox(
                  width: 120,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      textStyle: const TextStyle(fontSize: 14),
                      minimumSize: const Size(0, 36),
                    ),
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cerrar mesa'),
                          content: const Text('¿Cerrar la mesa y eliminar el pedido?'),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), textStyle: const TextStyle(fontSize: 13)),
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), textStyle: const TextStyle(fontSize: 13)),
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Cerrar', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        navigator.pop({'action': 'close', 'mesa': widget.pedido!.mesa, 'id': widget.pedido!.id});
                      }
                    },
                    child: const Text('Cerrar mesa'),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              SizedBox(
                width: 120,
                child: TextButton(
                  style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), textStyle: const TextStyle(fontSize: 14), minimumSize: const Size(0, 36)),
                  onPressed: () => Navigator.pop(context), 
                  child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 8), textStyle: const TextStyle(fontSize: 14), minimumSize: const Size(0, 36)),
                  onPressed: _guardarPedido,
                  child: const Text("Guardar Pedido"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _guardarPedido() {
    final pedido = _viewModel.generarPedido();
    if ((pedido.mesa.isEmpty) || _viewModel.productosSeleccionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rellena la mesa y añade productos antes de guardar'), duration: Duration(seconds: 1)),
      );
      return;
    }

    Navigator.pop(context, pedido);
  }
}
