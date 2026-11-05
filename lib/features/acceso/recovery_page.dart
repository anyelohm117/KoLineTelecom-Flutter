
import 'package:flutter/material.dart';

import '../../core/navigation/app_navigation.dart';
import '../../core/widgets/auth_shell.dart';
import '../../core/widgets/accent_button.dart';

// Pantalla para recuperar la contraseña del usuario
class RecoveryPage extends StatelessWidget {
  const RecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      title: 'Recuperar contraseña',
      children: [
        // Mensaje informativo
        const Text(
          'Introduce tu correo para recuperar el acceso.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),

        const SizedBox(height: 18),

        // Campo de correo electrónico
        const TextField(
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
            prefixIcon: Icon(
              Icons.email_outlined,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Botón para enviar instrucciones de recuperación
        AccentButton(
          label: 'Enviar instrucciones',
          onPressed: () {
            notice(context);
          },
        ),

        // Botón para regresar a la pantalla anterior
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Regresar',
          ),
        ),
      ],
    );
  }
}
