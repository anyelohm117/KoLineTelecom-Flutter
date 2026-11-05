
import '../models/ticket.dart';

// Contrato para la administración de tickets
abstract class TicketRepository {
  // Obtener todos los tickets registrados
  Future<List<Ticket>> obtenerTodos();

  // Guardar un nuevo ticket
  Future<void> guardar(Ticket ticket);

  // Actualizar el estado de un ticket existente
  Future<void> cambiarEstado(
    String id,
    EstadoTicket nuevoEstado,
  );
}
