import 'package:flutter/material.dart';
import 'package:t4_1/model/pedido.dart';
import 'package:t4_1/ui/app_theme.dart';


class Resumen extends StatelessWidget {
  const Resumen({super.key});

  @override
  Widget build(BuildContext context) {
    final Pedido? pedido = ModalRoute.of(context)!.settings.arguments as Pedido?;

    if (pedido == null) {
      return const Scaffold(body: Center(child: Text("Error: No hay datos")));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumen Final"),
        backgroundColor: Colors.orange, 
      ),
      body: Stack(
        children: [
          AppTheme.backgroundLogo(asset: 'assets/images/logoresumen.png'),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("MESA: ${pedido.mesa}", style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Center(
                  child: Column(
                    children: const [
                      Text('Bar Vader', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(height: 4),
                      Divider(thickness: 1),
                      Text('Únete al Lado Oscuro.....tenemos Happy Hour', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: pedido.productos.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final prod = pedido.productos[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${prod.cantidad} x ${prod.nombre}"),
                          Text("${(prod.precio * prod.cantidad).toStringAsFixed(2)} €"),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(thickness: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("TOTAL A PAGAR:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(
                        "${pedido.total.toStringAsFixed(2)} €",
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
                  Center(
                    child: SizedBox(
                      width: 140,
                      child: OutlinedButton(
                        style: AppTheme.actionOutlined(),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Volver a edición"),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}