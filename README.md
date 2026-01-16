# t4_1 — Gestión de pedidos (Flutter)

Descripción
-----------

`t4_1GestionBar` es una aplicación Flutter de ejemplo para la gestión de pedidos y productos de un bar, pensada como entregable para la asignatura. Incluye modelos para `pedido`, `producto` y la relación entre ellos, así como vistas para seleccionar productos y ver un resumen del pedido.

Características
---------------

- Gestión básica de productos y pedidos
- Pantallas para selección de productos y resumen del pedido
- Arquitectura con `viewModel` y separación de lógica y UI

Requisitos
---------

- Flutter SDK (versión compatible con Dart >= 3.9.2)
- Android Studio, Visual Studio Code u otro IDE con soporte Flutter

Instalación y ejecución
-----------------------

1. Clona el repositorio o descarga el proyecto.
2. Desde la raíz del proyecto, instala dependencias:

```bash
flutter pub get
```

3. Ejecuta la app en un emulador o dispositivo conectado:

```bash
flutter run
```

Estructura principal
--------------------

- `lib/main.dart`: punto de entrada de la aplicación
- `lib/view/`: pantallas (home, selección de productos, resumen)
- `lib/viewModel/`: lógica de presentación y estado
- `lib/model/`: modelos `pedido.dart`, `producto.dart`, `producto_pedido.dart`
- `assets/images/`: imágenes usadas en la app

Notas sobre desarrollo
----------------------

- Usa `flutter analyze` para revisar lints y problemas.
- Tests: se incluye un fichero de prueba de widget en `test/widget_test.dart`.

Autor y asignatura
-------------------

- Autor: Javier González Prados
- Asignatura: Desarrollo de Interfaces
- Ciclo: Desarrollo de Aplicaciones Multiplataforma (UDAM2)

Contribuciones
--------------

Pull requests bienvenidos. Para cambios mayores, abre un issue primero para discutir el diseño.

Licencia
--------

Sin licencia específica indicada en el repositorio.
