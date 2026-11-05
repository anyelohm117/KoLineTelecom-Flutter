
 // Estados disponibles para un ticket
enum EstadoTicket {
  abierto,
  enProceso,
  resuelto,
}

// Categorías de los tickets de soporte
enum CategoriaTicket {
  sinServicio,
  lentitud,
  otro,
}

// Modelo de datos para representar un ticket
class Ticket {
  // Identificación del ticket
  final String id;
  final String folio;

  // Información del cliente y problema
  final String cliente;
  final String asunto;
  final String descripcion;

  // Clasificación y estado del ticket
  final CategoriaTicket categoria;
  final EstadoTicket estado;

  // Fecha de registro
  final DateTime fechaCreacion;

  // Constructor del ticket
  const Ticket({
    required this.id,
    required this.folio,
    required this.cliente,
    required this.asunto,
    required this.descripcion,
    required this.categoria,
    required this.fechaCreacion,
    this.estado = EstadoTicket.abierto,
  });
}
