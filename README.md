# 🍺 GestionBar - Sistema de Gestión de Pedidos

<p align="center">
  <img width="399" height="549" alt="Captura de pantalla de GestionBar" src="https://github.com/user-attachments/assets/cea860ec-3d8e-4b8e-8c53-22859110eb50" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Version-1.0.0-green?style=for-the-badge" alt="Version">
</p>

## 📖 Descripción

**GestionBar** es una aplicación móvil desarrollada en Flutter para la gestión eficiente de pedidos y productos en un establecimiento tipo bar o cafetería. Diseñada como proyecto académico para la asignatura de Desarrollo de Interfaces, implementa una arquitectura MVVM (Model-View-ViewModel) con separación clara entre lógica de negocio y presentación.

## 🚀 Tecnologías Usadas

- **[Flutter](https://flutter.dev/)** - Framework multiplataforma para desarrollo móvil
- **[Dart](https://dart.dev/)** (>= 3.9.2) - Lenguaje de programación
- **Material Design** - Sistema de diseño para la interfaz de usuario
- **Cupertino Icons** - Iconografía iOS-style

## ✨ Características Principales

- 📦 **Gestión de Productos**: Catálogo completo de productos disponibles en el bar
- 🛒 **Sistema de Pedidos**: Creación y gestión de pedidos en tiempo real
- 🎨 **Interfaz Intuitiva**: Diseño limpio y fácil de usar basado en Material Design
- 📱 **Multiplataforma**: Compatible con Android, iOS, Web, Windows, Linux y macOS
- 🏗️ **Arquitectura MVVM**: Separación clara entre vistas y lógica de negocio
- 🔄 **Gestión de Estado**: ViewModel para manejo eficiente del estado de la aplicación
- 🖼️ **Recursos Visuales**: Imágenes integradas para productos

## 🛠️ Requisitos

- Flutter SDK (compatible con Dart >= 3.9.2)
- Android Studio, Visual Studio Code u otro IDE con soporte Flutter
- Emulador o dispositivo físico para pruebas

## 📥 Instalación y Ejecución

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/Javimix5/t4_1GestionBar.git
   cd t4_1GestionBar
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 📂 Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── view/                     # Pantallas de la interfaz
│   ├── home/                 # Pantalla principal
│   ├── selection/            # Selección de productos
│   └── summary/              # Resumen del pedido
├── viewModel/                # Lógica de presentación y estado
└── model/                    # Modelos de datos
    ├── pedido.dart           # Modelo de pedido
    ├── producto.dart         # Modelo de producto
    └── producto_pedido.dart  # Relación producto-pedido

assets/
└── images/                   # Recursos gráficos
```

## 🧪 Testing

Ejecutar análisis de código: 
```bash
flutter analyze
```

Ejecutar tests:
```bash
flutter test
```

## 👨‍💻 Autor

- **Javier González Prados**
- 📚 Asignatura: Desarrollo de Interfaces
- 🎓 Ciclo: Desarrollo de Aplicaciones Multiplataforma (UDAM2)

## 📄 Documentación Adicional

- [Manual de Usuario](manual-usuario.md)
- [Guía de Despliegue](guia_de_despliegue.md)

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Para cambios importantes: 

1. Abre un issue para discutir los cambios propuestos
2. Realiza un fork del proyecto
3. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
4. Commit de tus cambios (`git commit -m 'Add some AmazingFeature'`)
5. Push a la rama (`git push origin feature/AmazingFeature`)
6. Abre un Pull Request

## 📝 Licencia

Este proyecto es un trabajo académico sin licencia específica. 

---
