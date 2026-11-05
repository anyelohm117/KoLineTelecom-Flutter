import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/consulta_tickets/tickets_screen.dart';
import '../models/ticket.dart';
import '../providers/ticket_provider.dart';
import '../repositories/ticket_repository.dart';

/// Repositorio simulado exclusivo para las pruebas del Paso 05 de Vielka
class _TicketRepositoryMock implements TicketRepository {
  final List<Ticket> _ticketsSimulados = [
    Ticket(
      id: '1',
      folio: 'TK-V01',
      cliente: 'Ana López',
      asunto: 'Sin servicio de Internet',
      descripcion:
          'El cliente reporta intermitencia total de conexión desde la mañana.',
      categoria: CategoriaTicket.values.first,
      estado: EstadoTicket.abierto,
      fechaCreacion: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Ticket(
      id: '2',
      folio: 'TK-V02',
      cliente: 'Roberto Gómez',
      asunto: 'Lentitud en la red',
      descripcion: 'Navegación lenta al consumir contenido multimedia.',
      categoria: CategoriaTicket.values.length > 1
          ? CategoriaTicket.values[1]
          : CategoriaTicket.values.first,
      estado: EstadoTicket.enProceso,
      fechaCreacion: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Ticket(
      id: '3',
      folio: 'TK-V03',
      cliente: 'Carlos Ruiz',
      asunto: 'Cambio de contraseña Wi-Fi',
      descripcion: 'Solicitud atendida y configurada exitosamente.',
      categoria: CategoriaTicket.values.last,
      estado: EstadoTicket.resuelto,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Future<List<Ticket>> obtenerTodos() async {
    return List.from(_ticketsSimulados);
  }

  @override
  Future<void> guardar(Ticket ticket) async {
    final index = _ticketsSimulados.indexWhere((t) => t.id == ticket.id);
    if (index != -1) {
      _ticketsSimulados[index] = ticket;
    } else {
      _ticketsSimulados.add(ticket);
    }
  }

  @override
  Future<bool> cambiarEstado(String id, EstadoTicket nuevoEstado) async {
    final index = _ticketsSimulados.indexWhere((t) => t.id == id);
    if (index != -1) {
      final t = _ticketsSimulados[index];
      _ticketsSimulados[index] = Ticket(
        id: t.id,
        folio: t.folio,
        cliente: t.cliente,
        asunto: t.asunto,
        descripcion: t.descripcion,
        categoria: t.categoria,
        estado: nuevoEstado,
        fechaCreacion: t.fechaCreacion,
      );
      return true;
    }
    return false;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final repositorioMock = _TicketRepositoryMock();
  final ticketProvider = TicketProvider(repository: repositorioMock);
  ticketProvider.cargar();

  runApp(
    ChangeNotifierProvider.value(
      value: ticketProvider,
      child: const MaterialApp(
        title: 'Prueba Local - Vielka',
        debugShowCheckedModeBanner: false,
        home: TicketsScreen(),
      ),
    ),
  );
}
