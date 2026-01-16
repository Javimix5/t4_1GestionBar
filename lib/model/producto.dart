/// Modelo que representa un producto disponible en el bar.
/// 
/// Contiene un identificador, nombre, precio, cantidad disponible y una imagen opcional.
/// También proporciona un método para crear una copia del producto.
class Producto {
  final String id;
  final String nombre;
  final double precio;
  int cantidad;
  final String? image;

  Producto({required this.id, required this.nombre, required this.precio, this.cantidad = 0, this.image});

  Producto copy() => Producto(id: id, nombre: nombre, precio: precio, cantidad: cantidad, image: image);
}