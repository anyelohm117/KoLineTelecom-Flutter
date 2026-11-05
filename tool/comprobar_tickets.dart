import '../lib/models/ticket.dart';
import '../lib/repositories/ticket_repository_local.dart';

Future<void> main() async {
  final repo = TicketRepositoryLocal();
  final ticket = Ticket(
    id: '1',
    folio: 'TK-001',
    cliente: 'Cliente de prueba',
    asunto: 'Sin internet',
    descripcion: 'No hay conexión.',
    categoria: CategoriaTicket.sinServicio,
    fechaCreacion: DateTime.now(),
  );
  await repo.guardar(ticket);
  final lista = await repo.obtenerTodos();
  if (lista.length != 1 || lista.single.id != ticket.id) {
    throw StateError('Falló el registro o la consulta.');
  }
  print('OK: ticket registrado y consultado.');
  await repo.cambiarEstado(ticket.id, EstadoTicket.enProceso);
  final enProceso = (await repo.obtenerTodos()).single;
  if (enProceso.estado != EstadoTicket.enProceso ||
      enProceso.folio != ticket.folio) {
    throw StateError('Falló el cambio a En proceso.');
  }

  await repo.cambiarEstado(ticket.id, EstadoTicket.resuelto);
  final resuelto = (await repo.obtenerTodos()).single;
  if (resuelto.estado != EstadoTicket.resuelto || resuelto.id != ticket.id) {
    throw StateError('Falló el cambio a Resuelto.');
  }
  print('OK: cambios de estado verificados.');
  try {
    await repo.guardar(ticket);
  } on ArgumentError {
    print('OK: duplicado rechazado.');
    return;
  }
  throw StateError('Se permitió registrar un duplicado.');
}
