# Manual de Usuario — Bar Vader

---

Portada

- Versión: 1.0
- Fecha: 19 de enero de 2026
- Desarrollado por: Javier González Prados
- Contacto (email): javinano@gmail.com

---

Índice

- [Portada](#portada)
- [Índice](#índice)
- [Explicación de la aplicación](#explicación-de-la-aplicación)
  - [Seleccionar y añadir productos](#seleccionar-y-añadir-productos)
  - [Ajustar cantidades](#ajustar-cantidades)
  - [Ver resumen y total provisional](#ver-resumen-y-total-provisional)
  - [Guardar pedido y validaciones](#guardar-pedido-y-validaciones)
  - [Cerrar mesa](#cerrar-mesa)
- [Preguntas frecuentes (FAQ)](#preguntas-frecuentes-faq)
- [Contacto y soporte](#contacto-y-soporte)

---

## Explicación de la aplicación

Bar Vader es una aplicación para gestionar pedidos en un bar/mesa desde un dispositivo móvil o tableta. Permite seleccionar productos, ajustar cantidades, ver el resumen y guardar el pedido asociado a una mesa.

A continuación se describen las acciones más importantes.

### Seleccionar y añadir productos

- Pulsa en "Añadir Productos" para ir a la pantalla de selección. Allí puedes marcar los productos que quieres incluir en el pedido.
- Al regresar, los productos seleccionados aparecen en la lista del pedido.
- Al añadir o actualizar la selección, la app muestra un breve aviso (SnackBar) confirmando la acción.

### Ajustar cantidades

- En la lista del pedido usa los botones + y - para aumentar o disminuir la cantidad de cada producto.
- Si la cantidad baja a 0 el producto se elimina de la lista y se muestra un SnackBar indicando la eliminación.
- Los cambios actualizan el total provisional en la parte inferior.

### Ver resumen y total provisional

- El total provisional se muestra siempre en la parte inferior con formato numérico.
- Puedes pulsar "Ver Resumen" para ver un detalle del pedido antes de guardar.

### Guardar pedido y validaciones

- Para guardar un pedido debes indicar un identificador de mesa (campo "Mesa / Identificador") y añadir al menos un producto.
- El campo de mesa tiene validaciones: no puede estar vacío y debe tener al menos 2 caracteres.
- Si intentas guardar sin completar los campos obligatorios, la app mostrará mensajes de validación (debajo del campo) y un SnackBar explicando el error.
- Cuando el pedido se guarda correctamente verás un SnackBar de confirmación y, tras una breve espera, la pantalla vuelve a la anterior transmitiendo el pedido generado.

### Cerrar mesa

- Si estás editando un pedido existente aparece la opción "Cerrar mesa".
- Al seleccionar "Cerrar mesa" se pide confirmación. Confirmar elimina el pedido asociado a la mesa y notifica la acción a la pantalla anterior.

---

## Preguntas frecuentes (FAQ)

Q: ¿Qué hago si quiero cambiar la mesa de un pedido ya creado?

A: Abre el pedido en la pantalla de edición, modifica el campo "Mesa / Identificador" y guarda. El identificador se actualiza en el pedido.

Q: ¿Puedo deshacer una eliminación de producto?

A: No, esta versión no incluye la opción "Deshacer" en los SnackBars. Si borraste un producto, vuelve a añadirlo desde "Añadir Productos".

Q: ¿Qué pasa si cierro la app sin guardar?

A: Los cambios no guardados en el pedido se pierden. Guarda siempre antes de salir si quieres conservar el pedido.

Q: ¿Se comprueba el stock de productos?

A: Esta versión no valida stock automáticamente; recuerda ajustar cantidades manualmente.

---

## Contacto y soporte

- Para soporte técnico y errores, abre un issue en el repositorio de GitHub del proyecto o contacta por email a: javinano@gmail.com
- Incluye en tu mensaje: descripción del problema, pasos para reproducirlo y, si es posible, capturas de pantalla.

