# KoLineTelecom — Flutter

Proyecto académico en desarrollo para adaptar las interfaces de **KoLineTelecom** a Flutter. Su propósito es facilitar la consulta y el seguimiento de solicitudes de soporte técnico en una empresa de telecomunicaciones.

La propuesta parte del [proyecto original en PHP](https://github.com/anyelohm117/KoLineTelecom) y busca construir una interfaz que pueda evolucionar hacia una aplicación para web y dispositivos móviles.

## Estado del proyecto

**Etapa actual: beta incorporada; MVP local pendiente de desarrollo.**

El código de KoLineTelecom_Flutter_Demo.zip ya está incorporado en la raíz (`lib/` y `pubspec.yaml`), con entrada web y archivos de colaboración. La beta concentra todavía sus pantallas en `lib/main.dart`; su separación es una tarea pendiente.

Es un prototipo visual: la búsqueda y los formularios de registro/configuración no guardan datos; faltan detalle de tickets, Provider, Model, Repository, onboarding y assets propios. Esta preparación no implementa el MVP ni certifica la compilación.

La Etapa 1 debe funcionar con datos locales, sin Firebase ni API. La conexión externa corresponde a la Etapa 2.

## Problema que aborda

El proyecto busca apoyar la organización de solicitudes de soporte y ofrecer a los clientes una forma de consultar su seguimiento. También plantea una vista administrativa para organizar usuarios y tickets.

## Usuarios previstos

- **Administrador:** consulta general del sistema y gestión de usuarios y solicitudes.
- **Cliente:** registro de solicitudes y consulta de sus tickets.
- **Personal de soporte:** atención y seguimiento de solicitudes; sus permisos y flujo de trabajo se definirán durante el desarrollo.

## Alcance previsto del MVP

| Área | Alcance local por desarrollar |
| --- | --- |
| Entrada | Onboarding y perfil/acceso de demostración con validaciones. |
| Panel | Indicadores calculados desde los tickets locales. |
| Tickets | Listado, búsqueda y filtros, alta y cambio de estado. |
| Detalle | Pantalla que reciba el identificador del ticket como argumento. |
| Datos | Model, Repository local y estado compartido con Provider. |
| Diseño | Tema global, componentes reutilizables y assets propios. |

Esta tabla es el alcance acordado, no una lista de funciones terminadas. El estado y las responsabilidades se detallan en [Plan de Etapa 1](docs/PLAN_ETAPA1.md).

## Tecnologías

- **Flutter y Dart:** desarrollo de las interfaces.
- **Visual Studio Code:** entorno de trabajo.
- **Git y GitHub:** control de versiones y colaboración.

Esta entrega utiliza datos locales. El proyecto PHP/MySQL es una referencia, no un requisito de ejecución. La rúbrica prevé conectar Firebase en la Etapa 2 sustituyendo el Repository.

## Ejecución local

Los siguientes pasos ejecutan la beta web, pendiente de verificación en las laptops del equipo.

Se requiere Flutter >=3.27 con Dart >=3.6, Git y un navegador compatible. El mínimo corresponde al uso existente de `Color.withValues`. Los tres deben acordar la misma versión del SDK. Para VS Code, instala las extensiones Flutter y Dart.

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

Ejecuta los comandos desde la carpeta que contiene `pubspec.yaml`. La entrada web está incluida; no hace falta ejecutar `flutter create .` para Edge. Android todavía debe generarse y verificarse antes del APK: consulta [CONTRIBUTING.md](CONTRIBUTING.md). El primer `flutter pub get` genera `pubspec.lock`, que debe subirse después de acordar el SDK.

**Validación pendiente:** no se ejecutaron Flutter ni compilación en el entorno que preparó esta base. Registra en tu laptop el resultado de `flutter analyze` y de ejecutar el recorrido.

## Próximos pasos de Etapa 1

- Confirmar la ruta: cliente real o problemática social.
- Separar las pantallas y preparar Model, Repository y Provider siguiendo Vivero+.
- Completar listado, detalle con argumentos, alta y seguimiento de tickets.
- Completar entrada, assets, validaciones y pruebas.
- Revisar definición y wireframes; redactar documentación final del equipo.
- Preparar APK o video y demo de 5 a 7 minutos.

## Backlog de Etapa 2

- Firebase y persistencia externa mediante reemplazo del Repository.
- Autenticación y permisos reales.
- Sincronización entre usuarios y dispositivos.
- Gestión de cuentas y recuperación de contraseña.
- Despliegue y mejoras derivadas de la validación.

## Colaboración

Consulta [la guía de colaboración](CONTRIBUTING.md). Cada integrante desarrolla y prueba su función en una rama y abre un pull request hacia `main`. Las tareas están en [el plan](docs/PLAN_ETAPA1.md); las ramas se crean al empezar cada función. No hay avances atribuidos a Vielka o Deyla en esta preparación.

La procedencia de la beta y el apoyo de IA se registran en [AI_LOG.md](AI_LOG.md). El equipo debe revisar con el docente su reutilización y redactar su documentación final conforme a la rúbrica.

Evita subir contraseñas, tokens, archivos `.env`, datos reales de clientes o archivos generados de compilación. Conserva el `.gitignore` del proyecto Flutter.

## Autor

**Alberto Anyelo Hernández Martínez**  
[anyelohm117](https://github.com/anyelohm117)

Proyecto académico de Ingeniería en Tecnologías de la Información, Universidad Politécnica Metropolitana de Hidalgo.

