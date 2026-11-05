# Bitácora de apoyo de IA

Registro de procedencia, consultas y comprobaciones. Cada integrante añade sus usos reales; no se atribuyen a otras personas tareas que no realizaron.

## Antecedentes comprobados en esta conversación

- Herramienta: ChatGPT.
- Consulta: adaptar visualmente KoLineTelecom a Flutter.
- Resultado: prototipo KoLineTelecom_Flutter_Demo.zip y documentación inicial del repositorio con apoyo de IA.
- Alcance: generación previa de interfaces; autenticación y datos simulados.
- Revisión realizada: lectura de main.dart, pubspec.yaml y README del ZIP. Detectados búsqueda sin conectar, ausencia de Provider/Model/Repository y ausencia de detalle con argumentos.
- Pendiente: el equipo debe revisar con el docente la admisibilidad y forma de reutilizar ese material. No se declara como programación realizada por Vielka o Deyla.

## Preparación del repositorio solicitada por Anyelo

- Consulta: ordenar el repositorio, retirar información desactualizada e incorporar lo necesario para colaborar.
- Resultado utilizado: incorporación del código previo; declaración de Flutter >=3.27/Dart >=3.6 por el uso existente de Color.withValues; entrada web; reglas de Git, formato y archivos ignorados; guía de colaboración; plan y plantilla de pull request.
- Cambio pequeño en código: el aviso de función pendiente deja de afirmar que se necesita backend para implementar la Etapa 1 local.
- Documentación: se corrige el estado del README y se incorpora orientación. La redacción de la documentación final sigue pendiente del equipo según las reglas del docente.
- Verificación: revisión de archivos y configuración, comparación con el ZIP y lectura del repositorio tras publicar. Sin Flutter disponible en el entorno; no se declara compilación, análisis ni prueba en dispositivo.


## Próximas entradas

Añadir una entrada por uso con fecha real, integrante, herramienta, consulta, finalidad, resultado utilizado, adaptación propia y prueba ejecutada. Explicar también cuando una sugerencia se descarta. No marcar pruebas o revisiones que todavía no ocurrieron.


## Integración del perfil y onboarding — Anyelo

### Cambios realizados
Integré el trabajo inicial de Deyla con la aplicación principal:
bienvenida, perfil, acceso y panel. Añadí la edición del perfil,
el saludo personalizado y ajustes visuales con el estilo de KoLine.

### Apoyo recibido
ChatGPT proporcionó código parcial de integración
y correcciones. Revisé y ejecuté los cambios en mi computadora.

### Comprobación
- flutter analyze terminó sin errores.
- Se comprobó el recorrido de bienvenida a perfil, acceso y panel.
- La edición del perfil actualiza el saludo.
- El registro y cambio de estado de tickets siguen funcionando.

### Limitación
El perfil y los tickets se guardan en memoria durante la sesión.