import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/ticket.dart';
import '../../../providers/ticket_provider.dart';
import 'consulta_tickets_controller.dart';
import 'ticket_detalle_screen.dart';
import 'widgets/ticket_card.dart';

class TicketsScreen extends StatefulWidget {
  final bool embedded;

  const TicketsScreen({
    super.key,
    this.embedded = false,
  });

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  final _controller = ConsultaTicketsController();
  final _busquedaController = TextEditingController();

  @override
  void dispose() {
    _busquedaController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _abrirDetalle(String ticketId) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => TicketDetalleScreen(ticketId: ticketId),
      ),
    );
  }

  void _limpiarFiltros() {
    _busquedaController.clear();
    _controller.limpiarFiltros();
  }

  Future<void> _cambiarEstado(
    String id,
    EstadoTicket nuevoEstado,
  ) async {
    final provider = context.read<TicketProvider>();
    final guardado = await provider.cambiarEstado(id, nuevoEstado);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          guardado
              ? 'Estado actualizado correctamente.'
              : provider.error ?? 'No se pudo actualizar el estado.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TicketProvider>();

    final contenido = ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final filtrados = _controller.filtrar(provider.tickets);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tickets',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Busca tus reportes y consulta su seguimiento.',
              style: TextStyle(color: Colors.white60),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _busquedaController,
              decoration: InputDecoration(
                labelText: 'Buscar por folio, cliente o asunto',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _busquedaController.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Limpiar búsqueda',
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _busquedaController.clear();
                          _controller.actualizarConsulta('');
                        },
                      ),
              ),
              onChanged: _controller.actualizarConsulta,
            ),
            const SizedBox(height: 16),
            DropdownButton<EstadoTicket>(
              value: _controller.estadoSeleccionado,
              isExpanded: true,
              hint: const Text('Todos los estados'),
              items: const [
                DropdownMenuItem<EstadoTicket>(
                  value: null,
                  child: Text('Todos los estados'),
                ),
                DropdownMenuItem(
                  value: EstadoTicket.abierto,
                  child: Text('Abierto'),
                ),
                DropdownMenuItem(
                  value: EstadoTicket.enProceso,
                  child: Text('En proceso'),
                ),
                DropdownMenuItem(
                  value: EstadoTicket.resuelto,
                  child: Text('Resuelto'),
                ),
              ],
              onChanged: _controller.seleccionarEstado,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _limpiarFiltros,
                icon: const Icon(Icons.filter_alt_off_outlined),
                label: const Text('Limpiar filtros'),
              ),
            ),
            const SizedBox(height: 12),
            if (provider.cargando)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (provider.error != null) ...[
              Text(
                provider.error!,
                style: const TextStyle(color: Colors.redAccent),
              ),
              TextButton(
                onPressed: () => context.read<TicketProvider>().cargar(),
                child: const Text('Reintentar'),
              ),
            ] else if (provider.tickets.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'Todavía no hay tickets registrados. '
                  'Puedes crear uno desde las acciones del panel.',
                  textAlign: TextAlign.center,
                ),
              )
            else ...[
              Text(
                '${filtrados.length} de '
                '${provider.tickets.length} tickets',
                style: const TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 12),
              if (filtrados.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Text(
                    'No se encontraron tickets con los filtros aplicados.',
                    textAlign: TextAlign.center,
                  ),
                )
              else
                for (final ticket in filtrados)
                  TicketCard(
                    ticket: ticket,
                    onTap: () => _abrirDetalle(ticket.id),
                    onCambiarEstado: provider.cargando
                        ? null
                        : (estado) => _cambiarEstado(ticket.id, estado),
                  ),
            ],
          ],
        );
      },
    );

    if (widget.embedded) return contenido;

    return Scaffold(
      backgroundColor: navy,
      appBar: AppBar(title: const Text('Consulta de tickets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: contenido,
      ),
    );
  }
}
