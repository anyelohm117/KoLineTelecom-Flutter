import '../models/ticket.dart';

abstract class TicketRepository {
  Future<List<Ticket>> obtenerTodos();
  Future<void> guardar(Ticket ticket);
}
