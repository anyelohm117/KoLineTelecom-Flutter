# Bitácora - Vielka Ailyn Herrera

- **Integrante:** Vielka Ailyn Herrera
- **Módulo asignado:** Consulta de Tickets (`feature/vielka-consulta-tickets`)
- **Herramienta utilizada:** Gemini (Asistente de código)
- **Ruta de almacenamiento:** `docs/ai/vielka.md`

---

## Registro de Consultas y Adaptaciones

### Consulta 1: Estructuración del controlador y filtros combinados
- **Fecha:** 5 de noviembre de 2026
- **Herramienta:** Gemini
- **Finalidad:** Diseñar la lógica de búsqueda de texto y filtrado por estado de forma reactiva y limpia.
- **Sugerencia** Propuesta de métodos puros en un controlador para iterar la lista con condiciones `where` evaluando coincidencia de texto en múltiples propiedades (`folio`, `cliente`, `asunto`) junto al `EstadoTicket`.
- **Archivos afectados:** `lib/features/consulta_tickets/consulta_tickets_controller.dart`
- **Adaptación propia:** Ajusté la lógica para asegurarme de que el filtro maneje cadenas en minúsculas (`toLowerCase()`) evitando fallos por diferencias de mayúsculas/minúsculas en el buscador y retornando la lista intacta si el campo de texto está vacío.
- **Comprobación:** Pruebas unitarias de filtrado local comprobando que la búsqueda responde a folios parciales y nombres de cliente simultáneamente.

---

### Consulta 2: Corrección de tipos e incongruencias con los modelos compartidos
- **Fecha:** 5 de noviembre de 2026
- **Herramienta:** Gemini
- **Finalidad:** Resolver errores de análisis estático surgidos por diferencias entre el código planteado inicialmente y los modelos definidos en la rama `main`.
- **Código proporcionado:** Ajustar la lectura de enumeradores usando `.name` para `CategoriaTicket`, renombrar la propiedad `fecha` por `fechaCreacion`, reemplazar `value` por `initialValue` en el campo de texto e ignorar el estado `cerrado` por no existir en el modelo global.
- **Archivos afectados:**
  - `lib/features/consulta_tickets/tickets_screen.dart`
  - `lib/features/consulta_tickets/ticket_detalle_screen.dart`
- **Adaptación propia:** Revisé directamente los archivos `lib/models/ticket.dart` para confirmar los nombres exactos de los campos y enums antes de aplicar los cambios en las pantallas visuales.
- **Comprobación:** Ejecución de `flutter analyze` en la terminal Git Bash hasta obtener la respuesta `No issues found!`.

---

### Consulta 3: Punto de entrada aislado y Mock de datos para prueba Web
- **Fecha:** 5 de noviembre de 2026
- **Herramienta:** Gemini
- **Finalidad:** Solucionar la inmutabilidad de la lista devuelta por el provider al intentar inyectar tickets de prueba en el ejecutable aislado.
- **Sugerencia** Implementar una clase privada `_TicketRepositoryMock` dentro del runner que implemente la interfaz `TicketRepository` con los métodos `obtenerTodos()`, `guardar()` y `cambiarEstado()`.
- **Archivos afectados:** `lib/dev/main_vielka.dart`
- **Adaptación propia:** Configuré la lista estática del Mock utilizando la sintaxis defensiva `CategoriaTicket.values.first` y `CategoriaTicket.values.last` para evitar que cambios futuros en los enumeradores vuelvan a romper el punto de prueba.
- **Comprobación:** Compilación y ejecución exitosa en navegador mediante `flutter run -d chrome -t lib/dev/main_vielka.dart`, verificando la rendering fluida de la interfaz con los 3 tickets simulados.
