
import '../models/ticket.dart';
import 'ticket_repository.dart';

// Repositorio local para administrar tickets
class TicketRepositoryLocal implements TicketRepository {
  // Lista interna de tickets
  final List<Ticket> _tickets;

  // Constructor con datos iniciales opcionales
  TicketRepositoryLocal({
    List<Ticket> iniciales = const [],
  }) : _tickets = List<Ticket>.of(iniciales);

  // Obtener todos los tickets registrados
  @override
  Future<List<Ticket>> obtenerTodos() async {
    return List<Ticket>.unmodifiable(_tickets);
  }

  // Guardar un nuevo ticket
  @override
  Future<void> guardar(Ticket ticket) async {
    // Campos obligatorios del ticket
    final campos = [
      ticket.id,
      ticket.folio,
      ticket.cliente,
      ticket.asunto,
      ticket.descripcion,
    ];

    // Validar que los campos no estén vacíos
    if (campos.any((campo) => campo.trim().isEmpty)) {
      throw ArgumentError(
        'Completa los campos obligatorios.',
      );
    }

    // Verificar que el identificador o folio no exista
    if (_tickets.any(
      (t) => t.id == ticket.id || t.folio == ticket.folio,
    )) {
      throw ArgumentError(
        'Ya existe un ticket con ese identificador o folio.',
      );
    }

    // Agregar el ticket a la lista local
    _tickets.add(ticket);
  }

  // Actualizar el estado de un ticket existente
  @override
  Future<void> cambiarEstado(
    String id,
    EstadoTicket nuevoEstado,
  ) async {
    // Buscar el ticket por su identificador
    final indice = _tickets.indexWhere(
      (ticket) => ticket.id == id,
    );

    // Validar que el ticket exista
    if (indice == -1) {
      throw ArgumentError(
        'No se encontró el ticket.',
      );
    }

    // Obtener los datos actuales del ticket
    final actual = _tickets[indice];

    // Reemplazar el ticket con el nuevo estado
    _tickets[indice] = Ticket(
      id: actual.id,
      folio: actual.folio,
      cliente: actual.cliente,
      asunto: actual.asunto,
      descripcion: actual.descripcion,
      categoria: actual.categoria,
      estado: nuevoEstado,
      fechaCreacion: actual.fechaCreacion,
    );
  }
}
