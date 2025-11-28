class Producto {
  final String id;
  final String nombre;
  final double precio;
  int cantidad;
  final String? image;

  Producto({required this.id, required this.nombre, required this.precio, this.cantidad = 0, this.image});

  Producto copy() => Producto(id: id, nombre: nombre, precio: precio, cantidad: cantidad, image: image);
}