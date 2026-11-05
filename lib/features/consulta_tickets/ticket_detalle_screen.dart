import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ticket_provider.dart';
import 'consulta_tickets_controller.dart';
import 'widgets/estado_ticket_chip.dart';

/// Pantalla para visualizar los 8 campos de un ticket por su ID
class TicketDetalleScreen extends StatelessWidget {
  final String ticketId;

  const TicketDetalleScreen({
    super.key,
    required this.ticketId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TicketProvider>();
    final ticket =
        ConsultaTicketsController.buscarPorId(provider.tickets, ticketId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            ticket != null ? 'Detalle: ${ticket.folio}' : 'Detalle de Ticket'),
      ),
      body: ticket == null
          ? const Center(
              child: Text(
                'El ticket solicitado no existe o fue eliminado.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticket.folio,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      EstadoTicketChip(estado: ticket.estado),
                    ],
                  ),
                  const Divider(height: 24),
                  _CampoDetalle(titulo: 'ID', valor: ticket.id),
                  _CampoDetalle(titulo: 'Cliente', valor: ticket.cliente),
                  _CampoDetalle(titulo: 'Asunto', valor: ticket.asunto),
                  _CampoDetalle(
                      titulo: 'Categoría', valor: ticket.categoria.name),
                  _CampoDetalle(
                    titulo: 'Fecha de creación',
                    valor:
                        ticket.fechaCreacion.toLocal().toString().split('.')[0],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Descripción:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      ticket.descripcion,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _CampoDetalle extends StatelessWidget {
  final String titulo;
  final String valor;

  const _CampoDetalle({
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              '$titulo:',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              valor,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
