import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../features/perfil/data/perfil_repository_local.dart';
import '../features/perfil/perfil_controller.dart';
import '../features/perfil/perfil_screen.dart';

import '../features/perfil/onboarding_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PerfilController(
        repository: PerfilRepositoryLocal(),
      )..cargar(),
      child: const PruebaPerfilApp(),
    ),
  );
}

class PruebaPerfilApp extends StatelessWidget {
  const PruebaPerfilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba de perfil',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Builder(
        builder: (context) => OnboardingScreen(
          onContinuar: () {
            Navigator.of(context).pushReplacement<void, void>(
              MaterialPageRoute<void>(
                builder: (_) => const _ResumenPerfil(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ResumenPerfil extends StatelessWidget {
  const _ResumenPerfil();

  void _abrirFormulario(BuildContext context) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (routeContext) => PerfilScreen(
          onGuardado: () => Navigator.of(routeContext).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final perfil = context.watch<PerfilController>().perfil;

    return Scaffold(
      appBar: AppBar(title: const Text('Prueba de perfil local')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                perfil == null
                    ? 'Todavía no hay un perfil'
                    : 'Hola, ${perfil.nombre}',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              if (perfil != null) ...[
                const SizedBox(height: 12),
                Text(perfil.correo),
              ],
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => _abrirFormulario(context),
                child: Text(
                  perfil == null ? 'Crear perfil' : 'Editar perfil',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
