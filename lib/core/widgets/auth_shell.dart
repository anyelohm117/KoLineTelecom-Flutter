
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'backdrop.dart';
import 'brand.dart';

// Estructura principal de las pantallas de autenticación
class AuthShell extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AuthShell({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backdrop(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 455,
                ),

                // Contenedor principal del formulario
                child: Container(
                  padding: const EdgeInsets.all(32),

                  // Diseño y decoración
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white12,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: cyan.withValues(alpha: .07),
                        blurRadius: 45,
                      ),
                    ],
                  ),

                  // Contenido de la pantalla
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logotipo de la aplicación
                      const Brand(),
                      const SizedBox(height: 26),

                      // Título opcional
                      if (title.isNotEmpty) ...[
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 18),
                      ],

                      // Elementos del formulario
                      ...children,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
