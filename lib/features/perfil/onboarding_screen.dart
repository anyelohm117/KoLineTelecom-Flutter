import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final VoidCallback onContinuar;

  const OnboardingScreen({
    super.key,
    required this.onContinuar,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.hub_outlined,
                    size: 88,
                    color: tema.colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Bienvenido a KoLine Telecom',
                    textAlign: TextAlign.center,
                    style: tema.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Registra tus reportes de servicio y consulta '
                    'el avance de su atención.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Personaliza tu perfil'),
                    subtitle: Text('Añade tu nombre y correo.'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.confirmation_number_outlined),
                    title: Text('Gestiona tus tickets'),
                    subtitle: Text('Registra y consulta tus reportes.'),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: onContinuar,
                    child: const Text('Comenzar'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Versión de demostración local.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
