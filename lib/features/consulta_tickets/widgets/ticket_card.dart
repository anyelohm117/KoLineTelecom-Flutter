import 'package:flutter/material.dart';
import '../../../models/ticket.dart';
import 'estado_ticket_chip.dart';

/// Tarjeta para mostrar el resumen del ticket y menú de cambio de estado
class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback onTap;
  final ValueChanged<EstadoTicket>? onCambiarEstado;

  const TicketCard({
    super.key,
    required this.ticket,
    required this.onTap,
    this.onCambiarEstado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        onTap: onTap,
        title: Text(
          ticket.asunto,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Folio: ${ticket.folio} • Cliente: ${ticket.cliente}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            EstadoTicketChip(estado: ticket.estado),
            if (onCambiarEstado != null)
              PopupMenuButton<EstadoTicket>(
                icon: const Icon(Icons.more_vert),
                onSelected: onCambiarEstado,
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: EstadoTicket.abierto,
                    child: Text('Abierto'),
                  ),
                  PopupMenuItem(
                    value: EstadoTicket.enProceso,
                    child: Text('En proceso'),
                  ),
                  PopupMenuItem(
                    value: EstadoTicket.resuelto,
                    child: Text('Resuelto'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
