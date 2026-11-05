import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/auth_shell.dart';

class OnboardingScreen extends StatelessWidget {
  final VoidCallback onContinuar;

  const OnboardingScreen({
    super.key,
    required this.onContinuar,
  });

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      title: 'BIENVENIDO A TU PORTAL',
      children: [
        const Text(
          'Tu servicio, con seguimiento',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Registra tus reportes y consulta el avance '
          'de su atención desde un solo lugar.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),
        const ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.person_outline, color: cyan),
          title: Text('Personaliza tu perfil'),
          subtitle: Text('Añade tu nombre y correo.'),
        ),
        const ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            Icons.confirmation_number_outlined,
            color: cyan,
          ),
          title: Text('Gestiona tus reportes'),
          subtitle: Text('Registra tickets y consulta su estado.'),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: cyan,
              foregroundColor: navy,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: onContinuar,
            child: const Text(
              'COMENZAR →',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'DEMOSTRACIÓN LOCAL',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 11,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
