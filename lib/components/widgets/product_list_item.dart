import 'package:flutter/material.dart';
import 'package:t4_1/model/producto.dart';

/// Widget que representa un elemento de lista para un producto, mostrando su
/// nombre, precio, cantidad y botones para incrementar, decrementar o eliminar el producto.
/// También puede mostrar el precio total basado en la cantidad seleccionada.
class ProductListItem extends StatelessWidget {
  final Producto producto;
  final int cantidad;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onDelete;
  final bool showPrice;

  const ProductListItem({
    super.key,
    required this.producto,
    required this.cantidad,
    this.onIncrement,
    this.onDecrement,
    this.onDelete,
    this.showPrice = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            producto.image ?? '',
            width: 48,
            height: 48,
            fit: BoxFit.cover,

            /// Valida si la imagen existe, si no muestra un avatar con la inicial del producto.
            errorBuilder: (context, error, stackTrace) => CircleAvatar(child: Text(producto.nombre.isNotEmpty ? producto.nombre[0] : '?')),
          ),
        ),
        title: Text(producto.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${producto.precio} €"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.orange),
              iconSize: 20,
              padding: const EdgeInsets.all(6),
              constraints: const BoxConstraints(),
              onPressed: onDecrement,
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
              icon: const Icon(Icons.add_circle, color: Colors.green),
              iconSize: 20,
              padding: const EdgeInsets.all(6),
              constraints: const BoxConstraints(),
              onPressed: onIncrement,
            ),

            /// Valida si se proporciona el callback onDelete para mostrar el botón de eliminar.
            if (onDelete != null) ...[
              const SizedBox(width: 6),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                iconSize: 20,
                padding: const EdgeInsets.all(6),
                constraints: const BoxConstraints(),
                onPressed: onDelete,
              ),
            ],
            
            /// Valida si se debe mostrar el precio total basado en la cantidad seleccionada.
            if (showPrice) ...[
              const SizedBox(width: 12),
              SizedBox(
                width: 88,
                child: Text(
                  "${(producto.precio * cantidad).toStringAsFixed(2)} €",
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
