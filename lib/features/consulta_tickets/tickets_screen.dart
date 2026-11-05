import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/ticket.dart';
import '../../providers/ticket_provider.dart';
import 'consulta_tickets_controller.dart';
import 'ticket_detalle_screen.dart';
import 'widgets/ticket_card.dart';

/// Pantalla principal con el listado, búsqueda y filtrado de tickets
class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late final ConsultaTicketsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConsultaTicketsController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _abrirDetalle(String ticketId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TicketDetalleScreen(ticketId: ticketId),
      ),
    );
  }

  Future<void> _cambiarEstadoTicket(String id, EstadoTicket nuevoEstado) async {
    final provider = context.read<TicketProvider>();
    final exito = await provider.cambiarEstado(id, nuevoEstado);

    if (!mounted) return;

    if (exito) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Estado actualizado correctamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Error al actualizar el estado'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TicketProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Tickets'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar por folio, cliente o asunto',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _controller.actualizarConsulta,
                ),
                const SizedBox(height: 10),
                ListenableBuilder(
                  listenable: _controller,
                  builder: (context, _) {
                    return DropdownButtonFormField<EstadoTicket?>(
                      initialValue: _controller.estadoSeleccionado,
                      decoration: const InputDecoration(
                        labelText: 'Filtrar por estado',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: null,
                          child: Text('Todos'),
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
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (provider.cargando) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${provider.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => provider.cargar(),
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                }

                if (provider.tickets.isEmpty) {
                  return const Center(
                    child: Text('No hay tickets registrados en el sistema.'),
                  );
                }

                return ListenableBuilder(
                  listenable: _controller,
                  builder: (context, _) {
                    final ticketsFiltrados =
                        _controller.filtrar(provider.tickets);

                    if (ticketsFiltrados.isEmpty) {
                      return const Center(
                        child: Text(
                            'No se encontraron tickets con los filtros aplicados.'),
                      );
                    }

                    return ListView.builder(
                      itemCount: ticketsFiltrados.length,
                      itemBuilder: (context, index) {
                        final ticket = ticketsFiltrados[index];
                        return TicketCard(
                          ticket: ticket,
                          onTap: () => _abrirDetalle(ticket.id),
                          onCambiarEstado: (nuevoEstado) =>
                              _cambiarEstadoTicket(ticket.id, nuevoEstado),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
