import 'package:flutter/foundation.dart';
import '../../models/ticket.dart';

/// Controlador para gestionar los filtros de búsqueda y estado en la pantalla de tickets.
class ConsultaTicketsController extends ChangeNotifier {
  String _consulta = '';
  EstadoTicket? _estadoSeleccionado;

  String get consulta => _consulta;
  EstadoTicket? get estadoSeleccionado => _estadoSeleccionado;

  /// Actualiza el texto de búsqueda
  void actualizarConsulta(String nuevaConsulta) {
    _consulta = nuevaConsulta;
    notifyListeners();
  }

  /// Selecciona el estado a filtrar (null representa 'Todos')
  void seleccionarEstado(EstadoTicket? nuevoEstado) {
    _estadoSeleccionado = nuevoEstado;
    notifyListeners();
  }

  /// Restablece los filtros a su estado inicial
  void limpiarFiltros() {
    _consulta = '';
    _estadoSeleccionado = null;
    notifyListeners();
  }

  /// Método puro que aplica los filtros con lógica AND (búsqueda por folio, cliente o asunto + estado)
  List<Ticket> filtrar(List<Ticket> todos) {
    final q = _consulta.trim().toLowerCase();

    return todos.where((t) {
      final texto = '${t.folio} ${t.cliente} ${t.asunto}'.toLowerCase();
      final coincideTexto = q.isEmpty || texto.contains(q);
      final coincideEstado =
          _estadoSeleccionado == null || t.estado == _estadoSeleccionado;

      return coincideTexto && coincideEstado;
    }).toList(growable: false);
  }

  /// Método estático para buscar un ticket por ID para la vista de detalle
  static Ticket? buscarPorId(List<Ticket> todos, String ticketId) {
    try {
      return todos.firstWhere((t) => t.id == ticketId);
    } catch (_) {
      return null;
    }
  }
}
