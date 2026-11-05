import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/acceso/login_page.dart';
import 'providers/ticket_provider.dart';
import 'repositories/ticket_repository_local.dart';

void main() => runApp(
      ChangeNotifierProvider<TicketProvider>(
        lazy: false,
        create: (_) => TicketProvider(
          repository: TicketRepositoryLocal(),
        )..cargar(),
        child: const KoLineApp(),
      ),
    );

class KoLineApp extends StatelessWidget {
  const KoLineApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'KoLine Telecom',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const LoginPage(),
      );
}