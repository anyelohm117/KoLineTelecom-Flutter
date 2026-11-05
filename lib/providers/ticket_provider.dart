
import 'package:flutter/foundation.dart';

import '../models/ticket.dart';
import '../repositories/ticket_repository.dart';

// Administrador del estado de los tickets
class TicketProvider extends ChangeNotifier {
  // Repositorio de datos
  final TicketRepository repository;

  // Variables de estado
  List<Ticket> _tickets = [];
  bool _cargando = false;
  String? _error;

  // Constructor
  TicketProvider({
    required this.repository,
  });

  // Métodos de acceso al estado
  List<Ticket> get tickets => List<Ticket>.unmodifiable(_tickets);
  bool get cargando => _cargando;
  String? get error => _error;

  // Cargar todos los tickets
  Future<void> cargar() async {
    if (_cargando) return;

    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _tickets = await repository.obtenerTodos();
    } catch (e) {
      _error = 'Error al cargar los tickets: $e';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  // Registrar un nuevo ticket
  Future<bool> registrar(Ticket ticket) async {
    if (_cargando) return false;

    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      // Guardar el ticket en el repositorio
      await repository.guardar(ticket);

      // Actualizar la lista de tickets
      _tickets = [
        ..._tickets,
        ticket,
      ];

      return true;
    } catch (e) {
      _error = 'Error al guardar el ticket: $e';
      return false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  // Cambiar el estado de un ticket existente
  Future<bool> cambiarEstado(
    String id,
    EstadoTicket nuevoEstado,
  ) async {
    if (_cargando) return false;

    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      // Actualizar el estado en el repositorio
      await repository.cambiarEstado(
        id,
        nuevoEstado,
      );

      // Recargar la lista de tickets
      _tickets = await repository.obtenerTodos();

      return true;
    } catch (e) {
      _error = 'Error al cambiar el estado: $e';
      return false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}
