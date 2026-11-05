
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Componente de identidad visual de KoLine Telecom
class Brand extends StatelessWidget {
  const Brand({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Contenedor circular del logotipo
        Container(
          width: 110,
          height: 110,

          // Diseño del logotipo
          decoration: BoxDecoration(
            color: Colors.black38,
            shape: BoxShape.circle,
            border: Border.all(
              color: cyan.withValues(alpha: .5),
            ),
            boxShadow: [
              BoxShadow(
                color: cyan.withValues(alpha: .25),
                blurRadius: 25,
              ),
            ],
          ),

          // Icono principal
          child: const Icon(
            Icons.hub_outlined,
            color: cyan,
            size: 53,
          ),
        ),

        const SizedBox(height: 20),

        // Nombre de la aplicación
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'KoLine ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: 'Telecom',
                style: TextStyle(
                  color: cyan,
                ),
              ),
            ],
          ),
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 7),

        // Eslogan de la aplicación
        const Text(
          'ACCESO A LA RED',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 3,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}
