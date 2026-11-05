import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/backdrop.dart';
import '../../../models/ticket.dart';
import '../../../providers/ticket_provider.dart';
import 'consulta_tickets_controller.dart';
import 'widgets/estado_ticket_chip.dart';

class TicketDetalleScreen extends StatelessWidget {
  final String ticketId;

  const TicketDetalleScreen({
    super.key,
    required this.ticketId,
  });

  String _categoria(CategoriaTicket categoria) => switch (categoria) {
        CategoriaTicket.sinServicio => 'Sin servicio',
        CategoriaTicket.lentitud => 'Lentitud',
        CategoriaTicket.otro => 'Otro',
      };

  String _fecha(DateTime fecha) {
    final local = fecha.toLocal();
    String dos(int valor) => valor.toString().padLeft(2, '0');

    return '${dos(local.day)}/${dos(local.month)}/${local.year} '
        '${dos(local.hour)}:${dos(local.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TicketProvider>();
    final ticket = ConsultaTicketsController.buscarPorId(
      provider.tickets,
      ticketId,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: panel,
        title: Text(ticket?.folio ?? 'Detalle del ticket'),
      ),
      body: Backdrop(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Card(
                  color: panel,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                    side: const BorderSide(color: Colors.white12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: provider.cargando
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : provider.error != null
                            ? Text(
                                provider.error!,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                ),
                              )
                            : ticket == null
                                ? const Text(
                                    'El ticket solicitado no está disponible.',
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Icon(
                                        Icons.receipt_long_outlined,
                                        color: cyan,
                                        size: 48,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        ticket.asunto,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      _CampoDetalle(
                                        titulo: 'Folio',
                                        valor: ticket.folio,
                                      ),
                                      const Text(
                                        'Estado',
                                        style: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: EstadoTicketChip(
                                          estado: ticket.estado,
                                        ),
                                      ),
                                      const Divider(height: 32),
                                      _CampoDetalle(
                                        titulo: 'ID',
                                        valor: ticket.id,
                                      ),
                                      _CampoDetalle(
                                        titulo: 'Cliente',
                                        valor: ticket.cliente,
                                      ),
                                      _CampoDetalle(
                                        titulo: 'Categoría',
                                        valor: _categoria(ticket.categoria),
                                      ),
                                      _CampoDetalle(
                                        titulo: 'Fecha de creación',
                                        valor: _fecha(ticket.fechaCreacion),
                                      ),
                                      _CampoDetalle(
                                        titulo: 'Descripción',
                                        valor: ticket.descripcion,
                                      ),
                                    ],
                                  ),
                  ),
                ),
              ),
            ),
          ),
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          SelectableText(
            valor,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
