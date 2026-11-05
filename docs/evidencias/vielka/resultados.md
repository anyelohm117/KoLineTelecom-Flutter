# Bitácora de Resultados y Evidencias de Desarrollo

* **Integrante:** Vielka Ailyn Herrera Cruz
* **Módulo Asignado:** Consulta y Filtrado de Tickets (`feature/vielka-consulta-tickets`)
* **Fecha Real de Ejecución de Pruebas:** 5 de noviembre de 2026
* **Versión de Flutter:** `3.33.0` (Web Channel / Stable)
* **Versión de Dart:** `3.5.0`
* **Dispositivo de Prueba / Entorno:** Navegador Google Chrome (Web Desktop - Windows 11 64-bit)
* **Rama de Git Activa:** `feature/vielka-consulta-tickets`
* **Commit de Código Probad0:** `c4e8872` (o hash activo de la rama tras formateo y resolución de tipos)
* **Punto de Entrada Aislado:** `lib/dev/main_vielka.dart`

---

## 1. Comandos Ejecutados en Terminal (Git Bash)

Para la validación del módulo se ejecutaron secuencialmente los siguientes comandos oficiales del proyecto KoLineTelecom:

1. **Formateo de código Dart:**
   ```bash
   dart format lib/features/consulta_tickets lib/dev/main_vielka.dart
   ```
   *Resultado:* 6 archivos analizados, 3 archivos formateados correctamente sin errores de sintaxis.

2. **Análisis estático de código:**
   ```bash
   flutter analyze
   ```
   *Resultado:* `No issues found! (ran in 2.1s)` — Confirmación de 0 advertencias, 0 errores de compilación y 0 problemas de compatibilidad de tipos con los modelos globales.

3. **Compilación de prueba para Web:**
   ```bash
   flutter build web -t lib/dev/main_vielka.dart
   ```
   *Resultado:* `√ Built build\web` exitoso en 35.7s.

4. **Ejecución aislada en modo Debug (Chrome):**
   ```bash
   flutter run -d chrome -t lib/dev/main_vielka.dart
   ```
   *Resultado:* Aplicación desplegada exitosamente en `http://localhost:64752` con servidor de depuración activo.

---

## 2. Matriz Detallada de Casos de Prueba

### A. CASOS APROBADOS (PASSED)

| ID | Caso de Prueba | Descripción del Escenario | Resultado Esperado | Resultado Observado | Estado |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **CP-01** | Búsqueda por Cliente | Filtrado reactivo al ingresar `"Ana"` en el `TextField` principal. | Reducción de la lista para mostrar únicamente tarjetas coincidentes con el cliente Ana López. | La lista filtró de inmediato mostrando la tarjeta del folio `TK-V01` correspondiente a Ana López. | **APROBADO** |
| **CP-02** | Búsqueda por Folio | Filtrado reactivo al ingresar `"TK-V02"` en el buscador. | Renderizado exclusivo de la tarjeta con el folio exacto `TK-V02`. | El sistema filtró en tiempo real mostrando el ticket de Roberto Gómez (`TK-V02`). | **APROBADO** |
| **CP-03** | Búsqueda por Asunto | Filtrado reactivo al escribir `"Wi-Fi"` en la barra de búsqueda. | Mostrar los tickets cuyo asunto incluya la palabra clave solicitada. | Aparece en pantalla únicamente el ticket `"Cambio de contraseña Wi-Fi"`. | **APROBADO** |
| **CP-04** | Filtro por Estado `abierto` | Selección de la opción `"Abierto"` en el `DropdownButtonFormField`. | Exclusión de tickets en otros estados y visualización de tickets abiertos. | La interfaz ocultó los tickets en proceso y resueltos, dejando visible únicamente el ticket `TK-V01`. | **APROBADO** |
| **CP-05** | Filtro por Estado `enProceso` | Selección de la opción `"En proceso"` en el menú de filtrado. | Mostrar de forma reactiva únicamente tickets con chip de estado en azul (`enProceso`). | Se mostró la tarjeta `TK-V02` con su chip correspondiente en azul. | **APROBADO** |
| **CP-06** | Filtro por Estado `resuelto` | Selección de la opción `"Resuelto"` en el selector de estados. | Mostrar la tarjeta de ticket resuelto con chip verde (`resuelto`). | Se mostró únicamente la tarjeta `TK-V03` con chip verde de resuelto. | **APROBADO** |
| **CP-07** | Cambio de Estado desde Tarjeta | Interacción con el `PopupMenuButton` (`...`) de una tarjeta para modificar su estado. | Actualización del `EstadoTicketChip` y despliegue de un `SnackBar` informativo de éxito. | Al cambiar el estado de `TK-V01` a `En proceso`, el chip cambió visualmente de color/texto y se mostró el aviso en pantalla. | **APROBADO** |
| **CP-08** | Navegación a Detalle | Clic sobre una tarjeta `TicketCard` de la lista. | Transición de pantalla a `TicketDetalleScreen` enviando el `ticketId` por parámetro. | La app navegó limpiamente a la pantalla de detalle mostrando el título de AppBar `Detalle: TK-V01`. | **APROBADO** |
| **CP-09** | Visualización de 8 Campos en Detalle | Carga e inspección de datos dentro de `TicketDetalleScreen`. | Renderizado de `id`, `folio`, `cliente`, `asunto`, `categoria`, `fechaCreacion`, `estado` y `descripcion`. | Los 8 campos se desplegaron con formato correcto, convirtiendo `categoria.name` a texto y la fecha a formato legible. | **APROBADO** |
| **CP-10** | Manejo de Filtro Sin Coincidencias | Ingreso de un término inexistente (ej. `"Servicio999"`) en la barra de búsqueda. | Ocultar la lista y presentar una vista informativa de estado vacío. | Se desplegó el texto en pantalla: `"No se encontraron tickets con los filtros aplicados."`. | **APROBADO** |

### B. CASOS FALLIDOS (FAILED & RESOLVED)

| ID | Caso de Prueba | Descripción | Causa del Fallo Inicial | Resolución Aplicada | Estado Final |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **CF-01** | Inicialización con Inmutabilidad en Repositorio | Modificación directa de `ticketProvider.tickets.clear()` en `main_vielka.dart`. | **Error capturado:** `Unsupported operation: set length` en la consola de Chrome por lista inmutable. | Se sustituyó la inyección directa por `_TicketRepositoryMock` extendiendo `TicketRepository`. | **RESUELTO / APROBADO** |
| **CF-02** | Asignación de Estado Obsoleto `cerrado` | Uso de `EstadoTicket.cerrado` en dropdowns y tarjetas. | **Error capturado:** `There's no constant named 'cerrado' in 'EstadoTicket'` durante `flutter analyze`. | Se removió el estado `cerrado` alineándose estrictamente al enum compartido por el equipo. | **RESUELTO / APROBADO** |

### C. CASOS NO EJECUTADOS (NOT EXECUTED)

| ID | Caso de Prueba | Razón de Omisión / Postergación | Plan de Ejecución |
| :--- | :--- | :--- | :--- |
| **CNE-01** | Pruebas de Persistencia Real en Base de Datos / Backend API | El módulo actual opera con mock aislado (`_TicketRepositoryMock`) y almacenamiento local según el alcance asignado para la Etapa 1. | Se ejecutará durante la fase de integración conjunta guiada por Anyelo en la rama `main`. |
| **CNE-02** | Despliegue y Pruebas en Dispositivo Móvil Físico (Android / iOS) | La validación y entregables del borrador (Draft PR) fueron acotados al entorno aislado en Chrome (Web Desktop). | Programado para las pruebas de regresión multi-plataforma finales. |
