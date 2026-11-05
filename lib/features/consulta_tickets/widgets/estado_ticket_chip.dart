import 'package:flutter/material.dart';
import '../../../../models/ticket.dart';

/// Componente visual reutilizable para mostrar el estado de un ticket
class EstadoTicketChip extends StatelessWidget {
  final EstadoTicket estado;

  const EstadoTicketChip({
    super.key,
    required this.estado,
  });

  Color _obtenerColorEstado(EstadoTicket estado) {
    switch (estado) {
      case EstadoTicket.abierto:
        return Colors.orange;
      case EstadoTicket.enProceso:
        return Colors.blue;
      case EstadoTicket.resuelto:
        return Colors.green;
    }
  }

  String _obtenerTextoEstado(EstadoTicket estado) {
    switch (estado) {
      case EstadoTicket.abierto:
        return 'Abierto';
      case EstadoTicket.enProceso:
        return 'En proceso';
      case EstadoTicket.resuelto:
        return 'Resuelto';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _obtenerColorEstado(estado);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        _obtenerTextoEstado(estado),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
