import 'package:flutter/material.dart';
import 'package:t4_1/components/widgets/bottom_action_bar.dart';
import 'package:t4_1/components/widgets/product_list_item.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/model/producto.dart';
import 'package:t4_1/ui/app_theme.dart';
import 'package:t4_1/view/seleccion_productos.dart';
import 'package:t4_1/viewModel/pedido_view_model.dart';

/// Pantalla para crear o editar un pedido.
/// 
/// Permite seleccionar productos, ajustar cantidades y ver el total provisional.
/// También permite cerrar la mesa asociada al pedido. A través de un botón de "Cerrar mesa",
/// el cuál solo aparece si se está editando un pedido existente.
/// Incluye validaciones para asegurar que se ha especificado una mesa y se han añadido productos antes de guardar.
/// También maneja la eliminación de productos y la actualización de cantidades.
/// Utiliza SnackBars para notificar al usuario sobre acciones importantes.
/// Permite cancelar la creación/edición del pedido.
/// El diseño incluye un logo de fondo y una barra de acciones en la parte inferior.
class HacerPedido extends StatefulWidget {
  final Pedido? pedido;

  const HacerPedido({super.key, this.pedido});

  @override
  State<HacerPedido> createState() => _HacerPedidoState();
}

/// Estado de la pantalla HacerPedido.
class _HacerPedidoState extends State<HacerPedido> {
  final PedidoViewModel _viewModel = PedidoViewModel();
  final TextEditingController _mesaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mesaController.addListener(() {
      _viewModel.setMesa(_mesaController.text);
    });

    // Valida si se está editando un pedido existente para inicializar los datos.
    if (widget.pedido != null) {
      _mesaController.text = widget.pedido!.mesa;
      _viewModel.setMesa(widget.pedido!.mesa);
      _viewModel.setId(widget.pedido!.id);
      final copias = widget.pedido!.productos.map((p) => p.copy()).toList();
      _viewModel.actualizarProductos(copias);
    }
  }

  /// Libera los recursos del controlador de texto al desechar el estado.
  @override
  void dispose() {
    _mesaController.dispose();
    super.dispose();
  }

  /// Navega a la pantalla de selección de productos y actualiza la lista de productos seleccionados al regresar.
  Future<void> _irASeleccionarProductos() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeleccionProductos(
          initialSelected: _viewModel.productosSeleccionados,
        ),
      ),
    );

    /// Valida el resultado de la navegación y actualiza los productos seleccionados en consecuencia.
    if (!mounted) return;

    if (result is List<Producto>) {
      _viewModel.actualizarProductos(result);
    }
  }

  /// Elimina un producto de la lista de productos seleccionados y muestra un SnackBar notificando al usuario.
  void _eliminarProducto(String id) {
    final nueva = List<Producto>.from(_viewModel.productosSeleccionados);
    final prod = nueva.firstWhere(
      (p) => p.id == id,
      orElse: () => Producto(id: '', nombre: '', precio: 0),
    );
    nueva.removeWhere((p) => p.id == id);
    _viewModel.actualizarProductos(nueva);
    if (mounted && prod.id.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Producto "${prod.nombre}" eliminado'),
          duration: AppTheme.snackBarDuration,
        ),
      );
    }
  }

  /// Decrementa la cantidad de un producto seleccionado. Si la cantidad llega a cero, elimina el producto de la lista.
  /// Actualiza la lista de productos seleccionados y muestra un SnackBar si el producto es eliminado.
  /// Valida que el estado del widget aún está montado antes de mostrar el SnackBar.
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
            duration: AppTheme.snackBarDuration,
          ),
        );
      }
    }
    _viewModel.actualizarProductos(nueva);
  }

  /// Incrementa la cantidad de un producto seleccionado y actualiza la lista de productos seleccionados.
  void _incrementarProducto(String id) {
    final idx = _viewModel.productosSeleccionados.indexWhere((p) => p.id == id);
    if (idx == -1) return;
    final nueva = List<Producto>.from(_viewModel.productosSeleccionados);
    final prod = nueva[idx];
    prod.cantidad += 1;
    nueva[idx] = prod;
    _viewModel.actualizarProductos(nueva);
  }

  /// Navega a la pantalla de resumen del pedido actual.
  Future<void> _verResumen() async {
    await Navigator.pushNamed(
      context,
      '/resumen',
      arguments: _viewModel.generarPedido(),
    );
    if (!mounted) return;
  }

  /// Construye la interfaz de usuario de la pantalla HacerPedido.
  /// 
  /// Incluye un campo de texto para la mesa, una lista de productos seleccionados,
  /// un total provisional y botones para añadir productos, ver el resumen, guardar o cancelar el pedido
  /// y cerrar la mesa si se está editando un pedido existente.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pedido != null ? 'Editar Pedido' : 'Nuevo Pedido'),
      ),
      body: Stack(
        children: [
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
                              final prod =
                                  _viewModel.productosSeleccionados[index];
                              return ProductListItem(
                                producto: prod,
                                cantidad: prod.cantidad,
                                onIncrement: () =>
                                    _incrementarProducto(prod.id),
                                onDecrement: () =>
                                    _decrementarProducto(prod.id),
                                onDelete: () => _eliminarProducto(prod.id),
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
                            const Text(
                              "TOTAL PROVISIONAL:",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "${_viewModel.total.toStringAsFixed(2)} €",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
                                style: AppTheme.actionOutlined(),
                                onPressed: _irASeleccionarProductos,
                                child: const Text("Añadir Productos"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: AppTheme.confirmButton(Colors.orange),
                                onPressed:
                                    _viewModel.productosSeleccionados.isNotEmpty
                                    ? _verResumen
                                    : null,
                                child: const Text("Ver Resumen"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomActionBar(
        children: [

          /// Valida si se está editando un pedido existente para mostrar el botón de cerrar mesa.
          if (widget.pedido != null) ...[
            SizedBox(
              width: 120,
              child: TextButton(
                style: AppTheme.smallTextButton(
                  bg: Colors.red,
                  fg: Colors.white,
                ),
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Cerrar mesa'),
                      content: const Text(
                        '¿Cerrar la mesa y eliminar el pedido?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            'Cerrar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );

                  /// Si el usuario confirma, navega de regreso a la pantalla anterior con la acción de cerrar mesa.
                  if (confirm == true) {
                    navigator.pop({
                      'action': 'close',
                      'mesa': widget.pedido!.mesa,
                      'id': widget.pedido!.id,
                    });
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
              style: AppTheme.smallTextButton(),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 140,
            child: OutlinedButton(
              style: AppTheme.actionOutlined(),
              onPressed: _guardarPedido,
              child: const Text("Guardar Pedido"),
            ),
          ),
        ],
      ),
    );
  }

  /// Guarda el pedido actual si la mesa y los productos son válidos.
  /// Muestra un SnackBar si faltan datos obligatorios.
  /// Navega de regreso a la pantalla anterior con el pedido generado.
  void _guardarPedido() {
    final pedido = _viewModel.generarPedido();
    if ((pedido.mesa.isEmpty) || _viewModel.productosSeleccionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rellena la mesa y añade productos antes de guardar'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    Navigator.pop(context, pedido);
  }
}
