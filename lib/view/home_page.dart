import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/ui/app_theme.dart';
import 'package:t4_1/viewModel/home_view_model.dart';
import 'package:t4_1/view/hacer_pedido.dart' as crear_pedido;

/// Página principal que muestra la lista de pedidos activos.
/// 
/// Permite crear nuevos pedidos, editar existentes y cerrar mesas.
/// Utiliza un ViewModel para gestionar el estado de los pedidos.
/// También maneja la navegación hacia la página de creación/edición de pedidos.
/// Incluye confirmaciones para cerrar mesas y notificaciones mediante SnackBars.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();

  Future<void> _irACrearPedido([Pedido? pedido]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => crear_pedido.HacerPedido(pedido: pedido),
      ),
    );

    /// Valida el resultado de la navegación y actualiza el estado de los pedidos en consecuencia.
    if (!mounted) return;

    if (result is Map && result['action'] == 'close') {
      final id = result['id'] as String?;
      final mesa = result['mesa'] as String?;
      if (id != null) {
        _viewModel.eliminarPedidoById(id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Mesa "${mesa ?? ''}" cerrada'),
              duration: AppTheme.snackBarDuration,
            ),
          );
        }
      }
      return;
    }

    /// Valida y maneja la adición o actualización de un pedido.
    if (result is Pedido) {
      final normalizedNew = result.mesa.trim().toLowerCase();
      final dupIdx = _viewModel.pedidos.indexWhere(
        (p) => p.mesa.trim().toLowerCase() == normalizedNew,
      );
      if (dupIdx != -1 && _viewModel.pedidos[dupIdx].id != result.id) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ya existe una mesa con ese nombre o número'),
              duration: AppTheme.snackBarDuration,
            ),
          );
        }
        return;
      }

      /// Actualiza o agrega el pedido según corresponda.
      final existingIdx = _viewModel.pedidos.indexWhere(
        (p) => p.id == result.id,
      );
      if (existingIdx != -1) {
        _viewModel.actualizarPedidoById(result.id, result);
      } else {
        _viewModel.agregarPedido(result);
      }
    }
  }

  /// Construye la interfaz de usuario principal con la lista de pedidos y las acciones asociadas.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pedidos del Bar")),
      body: Stack(
        children: [
          AppTheme.backgroundLogo(),
          ListenableBuilder(
            listenable: _viewModel,
            builder: (context, child) {
              if (_viewModel.pedidos.isEmpty) {
                return const Align(
                  alignment: Alignment(0, -0.8),
                  child: Text(
                    "No hay pedidos activos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                );
              }

              /// Construye la lista de pedidos activos.
              /// Cada pedido muestra detalles y opciones para editar o cerrar la mesa.
              return ListView.builder(
                itemCount: _viewModel.pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = _viewModel.pedidos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      onTap: () => _irACrearPedido(pedido),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/empire.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                                  child: Text(
                                    "${pedido.numeroProductos}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      ),
                      title: Text(
                        pedido.mesa,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${pedido.numeroProductos} productos"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${pedido.total.toStringAsFixed(2)} €",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 12),
                          TextButton(
                            style: AppTheme.smallTextButton(
                              bg: Colors.red,
                              fg: Colors.white,
                            ),
                            child: const Text('Cerrar'),
                            onPressed: () async {
                              final messenger = ScaffoldMessenger.of(context);
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Cerrar mesa'),
                                  content: Text(
                                    '¿Confirmar cierre de la mesa "${pedido.mesa}"?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text(
                                        'Cerrar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              /// Si se confirma, elimina el pedido y muestra una notificación.
                              if (confirm == true) {
                                _viewModel.eliminarPedidoById(pedido.id);
                                messenger.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Mesa "${pedido.mesa}" cerrada',
                                    ),
                                    duration: AppTheme.snackBarDuration,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),

      /// Botón flotante para crear un nuevo pedido.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _irACrearPedido,
        label: const Text("Nuevo Pedido"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
