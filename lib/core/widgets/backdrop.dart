
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Fondo personalizado con degradado y efectos de iluminación
class Backdrop extends StatelessWidget {
  final Widget child;

  const Backdrop({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Degradado principal del fondo
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            navy,
            Color(0xFF051021),
            Colors.black,
          ],
        ),
      ),

      // Capas de iluminación y contenido
      child: Stack(
        children: [
          // Iluminación superior izquierda
          Positioned(
            top: -110,
            left: 30,
            child: _glow(cyan, 300),
          ),

          // Iluminación inferior derecha
          Positioned(
            bottom: -140,
            right: -90,
            child: _glow(Colors.blue, 320),
          ),

          // Contenido principal
          child,
        ],
      ),
    );
  }

  // Genera un efecto de iluminación circular
  Widget _glow(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .13),
            blurRadius: 130,
            spreadRadius: 30,
          ),
        ],
      ),
    );
  }
}
