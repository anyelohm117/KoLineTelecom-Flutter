import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../models/ticket.dart';
import 'estado_ticket_chip.dart';

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
      color: panel,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Colors.white12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.confirmation_number_outlined,
                    color: cyan,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      ticket.folio,
                      style: const TextStyle(
                        color: cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (onCambiarEstado != null)
                    PopupMenuButton<EstadoTicket>(
                      tooltip: 'Cambiar estado',
                      onSelected: onCambiarEstado,
                      itemBuilder: (_) => [
                        for (final estado in EstadoTicket.values)
                          CheckedPopupMenuItem<EstadoTicket>(
                            value: estado,
                            checked: estado == ticket.estado,
                            enabled: estado != ticket.estado,
                            child: Text(
                              switch (estado) {
                                EstadoTicket.abierto => 'Abierto',
                                EstadoTicket.enProceso => 'En proceso',
                                EstadoTicket.resuelto => 'Resuelto',
                              },
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                ticket.asunto,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ticket.cliente,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  EstadoTicketChip(estado: ticket.estado),
                  const Text(
                    'Ver detalle →',
                    style: TextStyle(color: cyan),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
