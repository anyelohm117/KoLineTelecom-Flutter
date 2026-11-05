
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Botón personalizado con color de acento
class AccentButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AccentButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,

      child: FilledButton(
        // Estilo del botón
        style: FilledButton.styleFrom(
          backgroundColor: cyan,
          foregroundColor: navy,

          // Bordes redondeados
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Acción al presionar
        onPressed: onPressed,

        // Texto del botón
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
