import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/perfil/data/perfil_repository_local.dart';
import 'features/perfil/inicio_page.dart';
import 'features/perfil/perfil_controller.dart';
import 'providers/ticket_provider.dart';
import 'repositories/ticket_repository_local.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TicketProvider>(
          lazy: false,
          create: (_) => TicketProvider(
            repository: TicketRepositoryLocal(),
          )..cargar(),
        ),
        ChangeNotifierProvider<PerfilController>(
          lazy: false,
          create: (_) => PerfilController(
            repository: PerfilRepositoryLocal(),
          )..cargar(),
        ),
      ],
      child: const KoLineApp(),
    ),
  );
}

class KoLineApp extends StatelessWidget {
  const KoLineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KoLine Telecom',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const InicioPage(),
    );
  }
}
