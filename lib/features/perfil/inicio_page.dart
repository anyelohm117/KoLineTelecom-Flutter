import 'package:flutter/material.dart';

import '../acceso/login_page.dart';
import 'onboarding_screen.dart';
import 'perfil_screen.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  int _paso = 0;

  @override
  Widget build(BuildContext context) {
    if (_paso == 0) {
      return OnboardingScreen(
        onContinuar: () => setState(() => _paso = 1),
      );
    }

    if (_paso == 1) {
      return PerfilScreen(
        onGuardado: () => setState(() => _paso = 2),
      );
    }

    return const LoginPage();
  }
}
