import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/navigation/app_navigation.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/accent_button.dart';
import '../../core/widgets/backdrop.dart';
import '../../models/ticket.dart';
import '../../providers/ticket_provider.dart';
import '../acceso/password_page.dart';
import '../perfil/perfil_controller.dart';
import '../perfil/perfil_screen.dart';
import '../tickets/ticket_form_page.dart';

class HomePage extends StatefulWidget {
  final bool admin;

  const HomePage({
    super.key,
    required this.admin,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  late bool admin = widget.admin;

  final items = const [
    (Icons.dashboard_outlined, 'Resumen'),
    (Icons.people_alt_outlined, 'Usuarios'),
    (Icons.receipt_long_outlined, 'Tickets'),
    (Icons.settings_outlined, 'Configuración'),
  ];

  void _abrirPerfil() {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (routeContext) => PerfilScreen(
          onGuardado: () => Navigator.of(routeContext).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final perfil = context.watch<PerfilController>().perfil;
    final estadoTickets = context.watch<TicketProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: panel,
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'KoLine '),
              TextSpan(
                text: 'Telecom',
                style: TextStyle(color: cyan),
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Mi cuenta',
            icon: const Icon(Icons.account_circle_outlined),
            onSelected: (valor) {
              switch (valor) {
                case 'perfil':
                  _abrirPerfil();
                  break;
                case 'rol':
                  setState(() => admin = !admin);
                  break;
                case 'clave':
                  go(context, const PasswordPage());
                  break;
                case 'salir':
                  Navigator.popUntil(
                    context,
                    (ruta) => ruta.isFirst,
                  );
                  break;
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'perfil',
                child: Text('Mi perfil'),
              ),
              PopupMenuItem(
                value: 'rol',
                child: Text(
                  'Vista ${admin ? 'cliente' : 'administrador'}',
                ),
              ),
              const PopupMenuItem(
                value: 'clave',
                child: Text('Cambiar contraseña'),
              ),
              const PopupMenuItem(
                value: 'salir',
                child: Text('Cerrar sesión'),
              ),
            ],
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, size) {
          return Row(
            children: [
              if (size.maxWidth > 750)
                SizedBox(
                  width: 230,
                  child: Material(
                    color: panel,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        const SizedBox(height: 25),
                        Center(
                          child: Text(
                            admin ? 'ADMINISTRACIÓN' : 'PORTAL CLIENTE',
                            style: const TextStyle(
                              color: cyan,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        for (var i = 0; i < items.length; i++)
                          ListTile(
                            selected: selected == i,
                            selectedColor: cyan,
                            leading: Icon(items[i].$1),
                            title: Text(items[i].$2),
                            onTap: () => setState(() => selected = i),
                          ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: Backdrop(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(25),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: _content(
                        estadoTickets,
                        perfil?.nombre,
                        perfil?.correo,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: MediaQuery.sizeOf(context).width <= 750
          ? NavigationBar(
              selectedIndex: selected,
              onDestinationSelected: (valor) {
                setState(() => selected = valor);
              },
              destinations: [
                for (final item in items)
                  NavigationDestination(
                    icon: Icon(item.$1),
                    label: item.$2,
                  ),
              ],
            )
          : null,
    );
  }

  String _nombreEstado(EstadoTicket estado) => switch (estado) {
        EstadoTicket.abierto => 'Abierto',
        EstadoTicket.enProceso => 'En proceso',
        EstadoTicket.resuelto => 'Resuelto',
      };

  Widget _content(
    TicketProvider estadoTickets,
    String? nombre,
    String? correo,
  ) {
    // Configuración conectada al perfil local.
    if (selected == 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Heading(
            'Configuración',
            'Tu perfil de esta sesión',
          ),
          const SizedBox(height: 15),
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.account_circle_outlined,
                  size: 64,
                  color: cyan,
                ),
                const SizedBox(height: 20),
                Text(
                  nombre ?? 'Sin perfil registrado',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  correo ?? 'Añade tu nombre y correo.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                AccentButton(
                  label: 'Editar perfil',
                  onPressed: _abrirPerfil,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Los datos se conservan durante esta sesión.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Tickets locales y cambio de estado.
    if (selected == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Heading(
            'Tickets',
            'Registros locales de esta sesión',
          ),
          const SizedBox(height: 18),
          if (estadoTickets.cargando)
            const CircularProgressIndicator()
          else if (estadoTickets.error != null)
            Text(estadoTickets.error!)
          else if (estadoTickets.tickets.isEmpty)
            const Text('Todavía no hay tickets registrados.')
          else
            for (final ticket in estadoTickets.tickets)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.confirmation_number,
                      color: cyan,
                    ),
                    title: Text(ticket.asunto),
                    subtitle: Text(
                      '${ticket.folio}\n'
                      '${ticket.cliente} • '
                      '${_nombreEstado(ticket.estado)}',
                    ),
                    isThreeLine: true,
                    trailing: PopupMenuButton<EstadoTicket>(
                      tooltip: 'Cambiar estado',
                      enabled: !estadoTickets.cargando,
                      initialValue: ticket.estado,
                      itemBuilder: (_) => [
                        for (final estado in EstadoTicket.values)
                          CheckedPopupMenuItem<EstadoTicket>(
                            value: estado,
                            checked: estado == ticket.estado,
                            enabled: estado != ticket.estado,
                            child: Text(_nombreEstado(estado)),
                          ),
                      ],
                      onSelected: (nuevoEstado) async {
                        final provider = context.read<TicketProvider>();

                        final guardado = await provider.cambiarEstado(
                          ticket.id,
                          nuevoEstado,
                        );

                        if (!mounted) return;

                        if (!guardado) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                provider.error ??
                                    'No se pudo cambiar el estado.',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
        ],
      );
    }

    // Usuarios de demostración.
    if (selected == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Heading(
            'Usuarios',
            'Consulta de registros • datos de demostración',
          ),
          const SizedBox(height: 18),
          _Card(
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Buscar usuarios',
                  ),
                ),
                const SizedBox(height: 12),
                for (var i = 0; i < 4; i++)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: cyan.withValues(alpha: .12),
                      child: const Icon(
                        Icons.person,
                        color: cyan,
                      ),
                    ),
                    title: Text('Usuario de ejemplo ${i + 1}'),
                    subtitle: const Text('Registro de demostración'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => notice(context),
                  ),
              ],
            ),
          ),
        ],
      );
    }

    // Resumen con saludo personalizado.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Heading(
          nombre == null ? 'Bienvenido a KoLine' : 'Hola, $nombre',
          'Panel ${admin ? 'administrativo' : 'de cliente'}'
          ' • KoLine Telecom',
        ),
        const SizedBox(height: 10),
        const Text(
          'Tickets con datos locales • los demás indicadores '
          'son demostrativos',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            const _Metric(
              icon: Icons.people_outline,
              title: 'Usuarios',
              value: '—',
            ),
            _Metric(
              icon: Icons.support_agent,
              title: 'Tickets registrados',
              value: estadoTickets.cargando
                  ? 'Cargando...'
                  : estadoTickets.error != null
                      ? 'Error'
                      : estadoTickets.tickets.length.toString(),
            ),
            const _Metric(
              icon: Icons.wifi,
              title: 'Servicios',
              value: '—',
            ),
            const _Metric(
              icon: Icons.monitor_heart_outlined,
              title: 'Estado de red',
              value: 'Sin conexión',
            ),
          ],
        ),
        const SizedBox(height: 22),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Acciones rápidas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => setState(() => selected = 1),
                    icon: const Icon(Icons.people_outline),
                    label: const Text('Ver usuarios'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => setState(() => selected = 2),
                    icon: const Icon(Icons.receipt_long),
                    label: const Text('Ver tickets'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => setState(() => admin = !admin),
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Cambiar vista de rol'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => go(
                      context,
                      const TicketFormPage(),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Nuevo ticket'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _abrirPerfil,
                    icon: const Icon(Icons.person_outline),
                    label: const Text('Mi perfil'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Heading extends StatelessWidget {
  final String title;
  final String subtitle;

  const _Heading(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.white60),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: panel.withValues(alpha: .92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: child,
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _Metric({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 225,
      child: _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: cyan, size: 28),
            const SizedBox(height: 17),
            Text(
              title,
              style: const TextStyle(color: Colors.white60),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
