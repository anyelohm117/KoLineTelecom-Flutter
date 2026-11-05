# Trabajo del equipo

Cada integrante desarrolla, prueba y explica su propia función. Se revisan los cambios mediante un pull request hacia `main`.

## Preparar la laptop

Instala Git y Flutter 3.27 o superior, con Dart 3.6 o superior. Recomendación: los tres usen la misma versión de Flutter y compartan la salida de `flutter --version` antes de empezar. Instala las extensiones Flutter y Dart en VS Code.

```bash
git clone https://github.com/anyelohm117/KoLineTelecom-Flutter.git
cd KoLineTelecom-Flutter
git config user.name "Tu nombre"
git config user.email "Tu correo verificado en GitHub"
flutter doctor
flutter pub get
flutter run -d edge
```

Edge corresponde a Windows. En otro sistema usa un dispositivo disponible en `flutter devices`. El soporte web ya está incluido: no hace falta ejecutar `flutter create .` para abrir esta beta en Edge.

La descarga inicial del SDK y dependencias requiere conexión. Las funciones previstas del MVP serán locales. La versión actual sigue siendo demostrativa.

## Permisos

Cada integrante debe aceptar su invitación al repositorio y autenticar Git con su propia cuenta. El nombre/correo del commit no sustituyen los permisos de acceso. No compartan contraseñas ni tokens.

## Crear una rama

Con el trabajo anterior guardado y el directorio limpio:

```bash
git switch main
git pull --ff-only origin main
```

Después crea una rama para tu función. Ejemplos:

```bash
git switch -c feature/vielka-consulta-tickets
```

```bash
git switch -c feature/deyla-perfil-onboarding
```

Ejecuta solamente el ejemplo correspondiente a tu tarea. Si la rama ya existe en GitHub, usa `git fetch origin` y luego `git switch --track origin/NOMBRE-DE-RAMA`, sustituyendo el nombre. Si ya existe localmente, usa `git switch NOMBRE-DE-RAMA`.

## Guardar y subir

```bash
flutter analyze
git status
git diff
```

Prepara los archivos concretos de tu función desde el botón + de Control de código fuente de VS Code. Evita subir archivos que no revisaste. Registra un mensaje sobre el cambio real:

```bash
git commit -m "Añade validaciones al perfil local"
git push -u origin HEAD
```

En el primer push se vincula la rama local con la remota; después basta `git push`.

En GitHub abre Compare & pull request y selecciona `main` como destino. Explica qué funciona, cómo lo probaste y qué falta. Anyelo revisa e integra; el autor atiende observaciones.

## Mantener una rama al día

Con los cambios guardados:

```bash
git fetch origin
git merge origin/main
flutter pub get
```

Si aparecen conflictos, coordina la resolución y vuelve a probar antes de subir. No uses `push --force` para reemplazar trabajo de otra persona. Cuando tu pull request se haya integrado, vuelve a `main`, actualiza y crea una rama nueva para la siguiente tarea.

## Evitar conflictos

Antes de modificar main.dart avisa en el equipo: la beta original todavía concentra ahí las pantallas. La separación e integración serán la primera tarea técnica de Anyelo. Las funciones de Vielka y Deyla deben trabajarse en archivos propios una vez acordada esa separación.

Anyelo coordina cambios en pubspec.yaml y archivos comunes. El primer `flutter pub get` generará pubspec.lock: acuerden una versión de Flutter y súbanlo para compartir la resolución de dependencias. No suban build/, .dart_tool/, credenciales ni datos reales de clientes.

Las ramas se crean al empezar cada función; no hay commits ni avances atribuidos a Vielka o Deyla en esta preparación.

## Android

Cuando corresponda preparar el APK, Anyelo genera una sola vez el soporte Android desde una rama propia:

```bash
flutter create --platforms=android --project-name=koline_telecom .
```

Antes y después revisa `git status` y `git diff`: conserva el código y la documentación del equipo, revisa los archivos nuevos y sustituye cualquier prueba de contador que genere Flutter por pruebas de la app. Publica los archivos de plataforma y verifica la compilación con `flutter build apk --debug`. Las demás laptops recibirán esa carpeta con `git pull`.

## Reglas académicas

Revisen docs/PLAN_ETAPA1.md y AI_LOG.md. Cada persona debe entender su código y registrar las consultas que utilice. Los archivos de orientación preparados con IA no equivalen a una entrega final redactada por el equipo.
