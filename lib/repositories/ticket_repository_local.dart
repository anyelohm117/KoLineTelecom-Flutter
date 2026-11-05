import '../models/ticket.dart';
import 'ticket_repository.dart';

class TicketRepositoryLocal implements TicketRepository {
  final List<Ticket> _tickets;

  TicketRepositoryLocal({List<Ticket> iniciales = const []})
      : _tickets = List<Ticket>.of(iniciales);

  @override
  Future<List<Ticket>> obtenerTodos() async {
    return List<Ticket>.unmodifiable(_tickets);
  }

  @override
  Future<void> guardar(Ticket ticket) async {
    final campos = [
      ticket.id,
      ticket.folio,
      ticket.cliente,
      ticket.asunto,
      ticket.descripcion,
    ];
    if (campos.any((campo) => campo.trim().isEmpty)) {
      throw ArgumentError('Completa los campos obligatorios.');
    }
    if (_tickets.any((t) => t.id == ticket.id || t.folio == ticket.folio)) {
      throw ArgumentError('Ya existe un ticket con ese identificador o folio.');
    }
    _tickets.add(ticket);
  }
}
