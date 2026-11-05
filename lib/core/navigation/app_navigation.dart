
import 'package:flutter/material.dart';

// Navegar hacia otra pantalla
void go(BuildContext context, Widget destination) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => destination,
    ),
  );
}

// Mostrar mensaje de función pendiente
void notice(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Función pendiente en esta beta. '
        'Se implementará con datos locales en la Etapa 1.',
      ),
    ),
  );
}
