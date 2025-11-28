import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/viewModel/homeViewModel.dart';
import 'package:t4_1/view/hacerPedido.dart' as crear_pedido;

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

    if (!mounted) return;

    if (result is Map && result['action'] == 'close') {
      final id = result['id'] as String?;
      final mesa = result['mesa'] as String?;
      if (id != null) {
        _viewModel.eliminarPedidoById(id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mesa "${mesa ?? ''}" cerrada')),
          );
        }
      }
      return;
    }

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
            ),
          );
        }
        return;
      }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pedidos del Bar")),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.08),
              colorBlendMode: BlendMode.darken,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),
          ListenableBuilder(
            listenable: _viewModel,
            builder: (context, child) {
              if (_viewModel.pedidos.isEmpty) {
                return const Align(
                  // (0, -0.5) sitúa el texto horizontalmente al centro (0)
                  // y verticalmente al 25% superior de la pantalla (-0.5),
                  // dejando espacio libre al logo en el centro.
                  alignment: Alignment(0, -0.8),
                  child: Text(
                    "No hay pedidos activos",
                    style: TextStyle(
                      fontSize: 20, // Hacemos el texto un poco más visible
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.black54, // Un color que contraste suavemente
                    ),
                  ),
                );
              }
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
                            errorBuilder: (context, error, stackTrace) => Center(
                              child: Text("${pedido.numeroProductos}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        pedido.mesa,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${pedido.numeroProductos} productos"
                      ),
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
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              textStyle: const TextStyle(fontSize: 14),
                              minimumSize: const Size(0, 36),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Text('Cerrar'),
                            onPressed: () async {
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
                              if (confirm == true) {
                                _viewModel.eliminarPedidoById(pedido.id);
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Mesa "${pedido.mesa}" cerrada',
                                      ),
                                    ),
                                  );
                                }
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _irACrearPedido,
        label: const Text("Nuevo Pedido"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
