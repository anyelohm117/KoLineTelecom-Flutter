# KoLineTelecom — Flutter

Proyecto académico en desarrollo para adaptar las interfaces de **KoLineTelecom** a Flutter. Su propósito es facilitar la consulta y el seguimiento de solicitudes de soporte técnico en una empresa de telecomunicaciones.

La propuesta parte del [proyecto original en PHP](https://github.com/anyelohm117/KoLineTelecom) y busca construir una interfaz que pueda evolucionar hacia una aplicación para web y dispositivos móviles.

## Estado del proyecto

**Etapa actual: beta de interfaces.**

La beta se encuentra en el entorno local de desarrollo y está pendiente de incorporarse a este repositorio. Por ahora, el repositorio contiene la documentación inicial; **todavía no es posible ejecutar la aplicación clonándolo**.

El alcance inicial corresponde a un prototipo visual navegable. La autenticación real, la persistencia de datos y la integración con el backend se consideran trabajo pendiente.

## Problema que aborda

El proyecto busca apoyar la organización de solicitudes de soporte y ofrecer a los clientes una forma de consultar su seguimiento. También plantea una vista administrativa para organizar usuarios y tickets.

## Usuarios previstos

- **Administrador:** consulta general del sistema y gestión de usuarios y solicitudes.
- **Cliente:** registro de solicitudes y consulta de sus tickets.
- **Personal de soporte:** atención y seguimiento de solicitudes; sus permisos y flujo de trabajo se definirán durante el desarrollo.

## Alcance previsto del MVP

| Área | Funcionalidad propuesta |
| --- | --- |
| Acceso | Interfaces de inicio de sesión, registro y recuperación de contraseña. |
| Administración | Panel con información general y consulta de usuarios y tickets. |
| Clientes | Panel para consultar y registrar solicitudes de soporte. |
| Tickets | Formulario de registro y consulta del seguimiento. |
| Cuenta | Interfaces de configuración y cambio de contraseña. |
| Navegación | Recorrido entre pantallas y adaptación de la interfaz al espacio disponible. |

Esta tabla describe el alcance previsto. La implementación de cada función se verificará cuando se incorpore y revise el código de la beta.

## Tecnologías

- **Flutter y Dart:** desarrollo de las interfaces.
- **Visual Studio Code:** entorno de trabajo.
- **Git y GitHub:** control de versiones y colaboración.

Se propone conservar **PHP y MySQL** como backend e integrar Flutter mediante una API. Esta conexión aún está pendiente; Flutter no debe conectarse directamente a MySQL ni incluir credenciales de la base de datos.

## Ejecución local

Los siguientes pasos aplicarán **cuando el código Flutter esté disponible en el repositorio**.

Se requiere Flutter SDK configurado, Git y un navegador compatible. Para trabajar desde VS Code, se recomiendan las extensiones Flutter y Dart.

```bash
git clone https://github.com/anyelohm117/KoLineTelecom-Flutter.git
cd KoLineTelecom-Flutter
flutter doctor
flutter pub get
flutter run -d edge
```

El comando de Edge está pensado para Windows. Para consultar los dispositivos disponibles:

```bash
flutter devices
```

Ejecuta los comandos de Flutter desde la carpeta que contiene `pubspec.yaml`. Si la beta no incluye las carpetas de plataforma, será necesario generarlas antes de ejecutarla.

## Próximos pasos

- Incorporar el código fuente de la beta y sus recursos.
- Verificar la compilación, la navegación y el diseño adaptable.
- Añadir el documento de definición y los wireframes.
- Definir los contratos de la API y los permisos de cada rol.
- Implementar y probar la autenticación y la gestión persistente de tickets.

## Colaboración

Para proponer cambios, trabaja en una rama propia y abre un pull request hacia `main`, indicando qué modificaste y cómo lo comprobaste.

Evita subir contraseñas, tokens, archivos `.env`, datos reales de clientes o archivos generados de compilación. Conserva el `.gitignore` del proyecto Flutter.

## Autor

**Alberto Anyelo Hernández Martínez**  
[anyelohm117](https://github.com/anyelohm117)

Proyecto académico de Ingeniería en Tecnologías de la Información, Universidad Politécnica Metropolitana de Hidalgo.
