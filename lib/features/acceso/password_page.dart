
import 'package:flutter/material.dart';

import '../../core/navigation/app_navigation.dart';
import '../../core/widgets/auth_shell.dart';
import '../../core/widgets/accent_button.dart';

// Pantalla para cambiar la contraseña del usuario
class PasswordPage extends StatelessWidget {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      title: 'Cambiar contraseña',
      children: [
        // Campo de contraseña actual
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Contraseña actual',
          ),
        ),

        const SizedBox(height: 15),

        // Campo de contraseña nueva
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Contraseña nueva',
          ),
        ),

        const SizedBox(height: 15),

        // Campo para confirmar la nueva contraseña
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirmar contraseña',
          ),
        ),

        const SizedBox(height: 20),

        // Botón para actualizar la contraseña
        AccentButton(
          label: 'Actualizar contraseña',
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
            'Volver',
          ),
        ),
      ],
    );
  }
}
