
import 'package:flutter/material.dart';
import 'app_colors.dart';

// Tema principal de la aplicación
final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: navy,

  // Esquema de colores
  colorScheme: ColorScheme.fromSeed(
    seedColor: cyan,
    brightness: Brightness.dark,
  ),

  // Estilo de los campos de entrada
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: field,

    // Borde predeterminado
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),

    // Borde cuando el campo está inactivo
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.white24,
      ),
    ),

    // Borde cuando el campo está seleccionado
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: cyan,
      ),
    ),

    // Espaciado interno
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 17,
    ),
  ),
);
