
import 'package:flutter/material.dart';

import '../../core/navigation/app_navigation.dart';
import '../../core/widgets/auth_shell.dart';
import '../../core/widgets/accent_button.dart';

// Pantalla para registrar nuevos usuarios
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      title: 'Crear cuenta',
      children: [
        // Campo de nombre completo
        const TextField(
          decoration: InputDecoration(
            labelText: 'Nombre completo',
            prefixIcon: Icon(
              Icons.person_outline,
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Campo de correo electrónico
        const TextField(
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
            prefixIcon: Icon(
              Icons.email_outlined,
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Campo de contraseña
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            prefixIcon: Icon(
              Icons.lock_outline,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Botón para registrar una cuenta
        AccentButton(
          label: 'Registrarme',
          onPressed: () {
            notice(context);
          },
        ),

        // Botón para regresar al inicio de sesión
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Volver al inicio de sesión',
          ),
        ),
      ],
    );
  }
}
