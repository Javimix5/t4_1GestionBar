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

## **Explicación de la aplicación**

### **Descripción general**

**Bar Vader** es una aplicación móvil desarrollada en Flutter para gestionar pedidos en un bar o restaurante desde dispositivos móviles o tabletas. La aplicación permite: 

✅ Gestionar múltiples mesas simultáneamente  
✅ Seleccionar productos de un catálogo predefinido  
✅ Ajustar cantidades de productos en tiempo real  
✅ Calcular el total provisional automáticamente  
✅ Ver un resumen detallado antes de guardar  
✅ Editar pedidos existentes  
✅ Cerrar mesas al finalizar el servicio  

La aplicación sigue una arquitectura MVVM (Model-View-ViewModel) que separa la lógica de negocio de la interfaz de usuario, garantizando un código limpio y mantenible. 

---

### **Pantalla principal: Lista de pedidos**

Al abrir la aplicación, se muestra la **pantalla principal** con:

- **Lista de pedidos activos**: Cada pedido muestra: 
  - El identificador de la mesa
  - Número de productos en el pedido
  - Total acumulado en euros
  - Botón "Cerrar" para finalizar la mesa
  
- **Botón flotante "Nuevo Pedido"**: En la esquina inferior derecha, permite crear un nuevo pedido. 

Si no hay pedidos activos, aparece el mensaje: _"No hay pedidos activos"_. 

**Acciones disponibles:**
- **Pulsar sobre un pedido**: Abre la pantalla de edición del pedido. 
- **Botón "Cerrar"**:  Solicita confirmación y cierra la mesa eliminando el pedido. 
- **Botón "Nuevo Pedido"**: Crea un nuevo pedido vacío. 

---

### **Crear un nuevo pedido**

Para crear un nuevo pedido: 

1. Pulsa el botón **"Nuevo Pedido"** en la pantalla principal. 
2. Se abre la pantalla de creación con:
   - Campo de texto **"Mesa / Identificador"** (obligatorio)
   - Lista vacía de productos
   - Total provisional:  **0.00 €**
3. Introduce el identificador de la mesa (ej: "MESA12", "Terraza 3").
4. Pulsa **"Añadir Productos"** para seleccionar artículos del catálogo. 

---

### **Seleccionar y añadir productos**

Para añadir productos a un pedido: 

1. Pulsa en **"Añadir Productos"** desde la pantalla de creación/edición.
2. Se abre la pantalla de selección mostrando el catálogo completo.
3. Marca los productos que deseas incluir usando los checkboxes.
4. Pulsa el botón de confirmación para regresar. 
5. Los productos seleccionados aparecen en la lista del pedido. 
6. Un **SnackBar** confirma:  _"Productos actualizados"_.

**Nota**: Si regresas sin seleccionar productos, la lista no se modifica.

---

### **Ajustar cantidades de productos**

Cada producto en la lista del pedido incluye controles para ajustar su cantidad:

- **Botón "+"**: Incrementa la cantidad en 1 unidad.
- **Botón "-"**: Disminuye la cantidad en 1 unidad.
- **Botón de papelera (🗑️)**: Elimina el producto directamente.

**Comportamiento importante:**
- Si reduces la cantidad a **0** usando el botón "-", el producto se elimina automáticamente.
- Al eliminar un producto aparece un SnackBar: _"Producto [nombre] eliminado"_.
- El **total provisional** se actualiza automáticamente tras cada cambio.

---
### **Ver resumen del pedido**

Antes de guardar, puedes revisar el pedido completo:

1. Pulsa **"Ver Resumen"** en la parte inferior de la pantalla.
2. Se abre una nueva pantalla mostrando:
   - Identificador de la mesa
   - Nombre del bar:  **"Bar Vader"**
   - Eslogan: _"Únete al Lado Oscuro.....tenemos Happy Hour"_
   - Lista detallada de productos con cantidades y subtotales
   - **TOTAL A PAGAR** en euros
3. Pulsa **"Volver a edición"** para regresar y hacer cambios.

**Nota**: El botón "Ver Resumen" solo está habilitado si hay al menos un producto en el pedido.

---

### **Guardar pedido y validaciones**

Para guardar un pedido, debes cumplir estos requisitos: 

✔️ **Identificador de mesa**: No puede estar vacío y debe tener al menos **2 caracteres**.  
✔️ **Al menos un producto**: Debe haber productos en la lista. 

**Proceso de guardado:**

1. Completa el campo **"Mesa / Identificador"**. 
2. Añade al menos un producto. 
3. Pulsa **"Guardar Pedido"**. 
4. Si hay errores de validación: 
   - Aparece un mensaje debajo del campo (ej: _"Introduce la mesa"_)
   - Un SnackBar explica el error:  _"Corrige los errores antes de guardar"_
5. Si todo es correcto: 
   - Aparece un SnackBar: _"Pedido guardado"_
   - Tras 0.7 segundos, regresas a la pantalla principal
   - El pedido aparece en la lista de pedidos activos

**Validaciones específicas:**
- Mesa vacía → _"Introduce la mesa"_
- Mesa con menos de 2 caracteres → _"Identificador demasiado corto"_
- Sin productos → _"Rellena la mesa y añade productos antes de guardar"_
- Mesa duplicada → _"Ya existe una mesa con ese nombre o número"_

---

<div style="page-break-after: always;"></div>

### **Editar un pedido existente**

Para modificar un pedido ya creado:

1. En la pantalla principal, pulsa sobre el pedido que deseas editar.
2. Se abre la pantalla de edición con:
   - Título: **"Editar Pedido"**
   - Campo de mesa prellenado
   - Lista de productos actual
   - Botón adicional: **"Cerrar mesa"** (color rojo)
3. Modifica el identificador de la mesa si es necesario.
4. Añade, elimina o ajusta cantidades de productos. 
5. Pulsa **"Guardar Pedido"** para confirmar los cambios.

**Diferencia con crear pedido:**
- Al editar aparece el botón "Cerrar mesa" en la barra inferior.
- Los datos se precargan con la información del pedido existente.

---

### **Cerrar mesa**

Existen **dos formas** de cerrar una mesa:

#### **Opción 1: Desde la pantalla principal**
1. Pulsa el botón **"Cerrar"** junto al pedido.
2. Aparece un diálogo de confirmación:  _"¿Confirmar cierre de la mesa [nombre]?"_
3. Pulsa **"Cerrar"** para confirmar o **"Cancelar"** para abortar. 
4. Si confirmas, el pedido se elimina y aparece un SnackBar:  _"Mesa [nombre] cerrada"_. 

#### **Opción 2: Desde la pantalla de edición**
1. Abre el pedido y pulsa **"Cerrar mesa"** en la barra inferior. 
2. Aparece un diálogo:  _"¿Cerrar la mesa y eliminar el pedido?"_
3. Pulsa **"Cerrar"** para confirmar. 
4. Regresas a la pantalla principal y el pedido desaparece de la lista. 
5. Aparece un SnackBar: _"Mesa [nombre] cerrada"_.

**⚠️ Importante**:  Cerrar una mesa elimina el pedido permanentemente y no se puede deshacer.

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

