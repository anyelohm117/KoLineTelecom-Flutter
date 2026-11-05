enum EstadoTicket { abierto, enProceso, resuelto }

enum CategoriaTicket { sinServicio, lentitud, otro }

class Ticket {
  final String id;
  final String folio;
  final String cliente;
  final String asunto;
  final String descripcion;
  final CategoriaTicket categoria;
  final EstadoTicket estado;
  final DateTime fechaCreacion;

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
