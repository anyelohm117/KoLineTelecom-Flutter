
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/navigation/app_navigation.dart';
import '../../core/widgets/auth_shell.dart';
import '../../core/widgets/accent_button.dart';

import '../panel/home_page.dart';
import 'register_page.dart';
import 'recovery_page.dart';

// Pantalla principal de inicio de sesión
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores y clave del formulario
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  // Control de visibilidad de la contraseña
  bool obscured = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      title: '',
      children: [
        // Formulario de inicio de sesión
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo de correo electrónico
              const _Label('CORREO ELECTRÓNICO'),

              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'usuario@koline.com',
                ),
                validator: (v) {
                  return v == null || !v.contains('@')
                      ? 'Introduce un correo válido'
                      : null;
                },
              ),

              const SizedBox(height: 20),

              // Campo de contraseña
              const _Label('CONTRASEÑA'),

              TextFormField(
                controller: password,
                obscureText: obscured,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  hintText: '••••••••',

                  // Mostrar u ocultar contraseña
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscured
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        obscured = !obscured;
                      });
                    },
                  ),
                ),
                validator: (v) {
                  return v == null || v.isEmpty
                      ? 'Introduce la contraseña'
                      : null;
                },
              ),

              const SizedBox(height: 25),

              // Botón de inicio de sesión
              AccentButton(
                label: 'Iniciar sesión →',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    go(
                      context,
                      const HomePage(admin: true),
                    );
                  }
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        const Divider(color: Colors.white12),

        // Opción para registrar una cuenta
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              '¿No tienes cuenta?',
              style: TextStyle(
                color: Colors.white60,
              ),
            ),

            TextButton(
              onPressed: () {
                go(context, const RegisterPage());
              },
              child: const Text(
                'Regístrate aquí',
                style: TextStyle(
                  color: cyan,
                ),
              ),
            ),
          ],
        ),

        // Recuperación de contraseña
        TextButton(
          onPressed: () {
            go(context, const RecoveryPage());
          },
          child: const Text(
            'Olvidé mi contraseña',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Mensaje informativo de la versión demo
        const Text(
          'DEMO: cualquier correo válido y contraseña '
          'abren el panel visual.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white38,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

// Etiqueta personalizada para los campos del formulario
class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        text,
        style: const TextStyle(
          color: cyan,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
