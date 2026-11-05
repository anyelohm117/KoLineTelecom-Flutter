# Plan y estado de Etapa 1

## Base incorporada

Se incorpora la beta del ZIP KoLineTelecom_Flutter_Demo.zip proporcionado por Anyelo. Es un prototipo de interfaces: no es un MVP terminado.

Implementado en esa beta:
- Tema global azul oscuro/cian y componentes propios reutilizables.
- Acceso simulado con validaciones básicas.
- Navegación entre acceso, registro, recuperación, panel y cambio de contraseña.
- Vistas de usuarios, tickets y configuración con información ilustrativa.

Limitaciones verificadas leyendo el código:
- La búsqueda no filtra y pulsar un ticket no abre un detalle.
- No hay Provider, Model ni Repository.
- Formularios distintos del acceso muestran avisos y no guardan datos.
- No existen onboarding ni imágenes/assets propios.
- Los indicadores y cambios de rol son demostrativos.
- Las pantallas y su lógica siguen dentro de main.dart.

La organización del repositorio no implica que estos requisitos estén completados.

## Alcance acordado para desarrollar

Onboarding, perfil/acceso de demostración, panel, listado de tickets con búsqueda y filtros, registro de ticket y detalle con argumentos. Cambios de estado compartidos con Provider y datos locales. La persistencia después de cerrar es opcional y todavía no está implementada.

Datos propuestos de ticket: identificador, folio, cliente, asunto, descripción, categoría, estado y fecha de creación. Categorías: Sin servicio, Lentitud y Otro. Estados: Abierto, En proceso y Resuelto. Confirmar los datos y operaciones antes de empezar las ramas de interfaz.

## Funciones propias

| Integrante | Tarea | Evidencia esperada |
| --- | --- | --- |
| Anyelo | Separación del código, Model/Repository de tickets, Provider, alta, cambio de estado e integración | Registro válido visible en listado e indicadores; datos separados de las pantallas. |
| Vielka | Listado, búsqueda, filtros y detalle con argumentos; tema y componentes | Resultados correctos y detalle correspondiente al ticket seleccionado. |
| Deyla | Onboarding y perfil local con nombre/correo, validaciones y sus datos | Entradas inválidas rechazadas y nombre mostrado en el panel durante la sesión. |

Cada integrante desarrolla pantalla, lógica y datos de su función. El apoyo de Anyelo no sustituye la participación individual.

## Orden de integración

1. Acordar datos y operaciones; separar la beta siguiendo Vivero+.
2. Publicar una base que compile y pueda utilizar el equipo.
3. Desarrollar funciones en ramas distintas y revisar mediante pull requests.
4. Integrar y comprobar altas, búsquedas, argumentos y cambios de estado.
5. Completar assets, validación, documentación y demostración.

Registro/recuperación/cambio de contraseña y usuarios seguirán como pantallas de demostración hasta que se decida su retiro del recorrido o su implementación. No hay eliminación de funciones silenciosa en esta preparación.

## Checklist de rúbrica

- [ ] Definición con problema, usuarios, requisitos must/should/could y alcance.
- [ ] Wireframes del recorrido final.
- [ ] Onboarding o Splash y al menos cuatro pantallas navegables.
- [ ] Búsqueda o filtros funcionales.
- [ ] Detalle con argumentos.
- [ ] Provider compartido y uso correcto de watch/read.
- [ ] Tema y al menos dos componentes propios revisados en ejecución.
- [ ] Assets propios declarados en pubspec.yaml.
- [ ] Model/Repository y separación de la lógica.
- [ ] Validaciones y recorrido sin fallos.
- [ ] Compilación y ejecución verificadas en una laptop del equipo.
- [ ] Commits de los tres y revisión de cambios.
- [ ] README final del equipo con instalación, capturas, decisiones y fuentes.
- [ ] AI_LOG actualizado por cada integrante.
- [ ] Evidencias reales de la ruta elegida.
- [ ] APK o video y demo de 5 a 7 minutos.
- [ ] Backlog de Etapa 2 dentro del README.

Las casillas están pendientes de verificación: no representan puntuación obtenida.

## Ruta pendiente de confirmar (25 puntos)

A: cliente real participante; al menos dos reuniones con requisitos confirmados, adaptación al cliente y prueba de prototipo/MVP con retroalimentación y plan para Etapa 2.

B: problemática social; fuentes y datos confiables, población afectada, ODS, justificación de viabilidad e idea y validación con al menos cinco personas del público objetivo.

La ejecución local no elimina las evidencias. No se incluyen reuniones ni resultados inventados.

## Documentación final y uso de IA

La rúbrica permite conceptos, sugerencias, revisión y fragmentos pequeños (referencia: hasta 20 líneas por consulta). Prohíbe generar pantallas, módulos, funciones completas, arquitectura, README final, investigación y evidencias mediante IA. El equipo debe revisar con el docente la reutilización de la beta y README anteriores generados con apoyo de ChatGPT; su incorporación aquí se registra en AI_LOG.md.

Esta preparación aporta archivos de configuración y orientación, sin implementar las funciones completas pendientes ni acreditar participación ajena.

## Validación de esta preparación

Se revisaron el contenido del ZIP, las rutas y los archivos publicados. El entorno de preparación no dispone de Flutter; no se ejecutó flutter analyze ni se compiló la aplicación. La primera comprobación en las laptops del equipo debe registrar versión de Flutter, comandos y resultados reales.
