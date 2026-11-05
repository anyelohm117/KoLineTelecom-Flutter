import 'package:flutter/foundation.dart';
import 'models/perfil_repository.dart';
import 'models/perfil_local.dart';

/// Coordina la carga y el guardado del perfil y expone su estado a la UI.
class PerfilController extends ChangeNotifier {
  /// Repositorio utilizado para leer y guardar los datos del perfil.
  final PerfilRepository repository;

  /// Crea un controlador asociado al [repository] indicado.
  PerfilController({required this.repository});

  /// Perfil que se cargó o guardó correctamente.
  PerfilLocal? _perfil;

  /// Indica si hay una operación de guardado en curso.
  bool _guardando = false;

  /// Mensaje del último error ocurrido, si lo hubo.
  String? _error;

  /// Perfil actual, o `null` antes de cargar o guardar uno.
  PerfilLocal? get perfil => _perfil;

  /// Indica si se está guardando el perfil.
  bool get guardando => _guardando;

  /// Mensaje del último error, o `null` si no hay errores.
  String? get error => _error;

  /// Carga el perfil desde el repositorio y notifica el resultado a la UI.
  Future<void> cargar() async {
    _error = null;

    try {
      _perfil = await repository.leer();
    } catch (_) {
      _error = 'No se pudo cargar el perfil.';
    } finally {
      notifyListeners();
    }
  }

  /// Valida y guarda los datos recibidos.
  ///
  /// Devuelve `false` si ya hay otro guardado en curso o si ocurre un error.
  Future<bool> guardar(String nombre, String correo) async {
    if (_guardando) return false;

    _guardando = true;
    _error = null;
    notifyListeners();

    try {
      final nuevoPerfil = PerfilLocal(
        nombre: nombre.trim(),
        correo: correo.trim(),
      );

      await repository.guardar(nuevoPerfil);
      _perfil = nuevoPerfil;
      return true;
    } on ArgumentError catch (e) {
      _error = e.message.toString();
      return false;
    } catch (_) {
      _error = 'No se pudo guardar el perfil.';
      return false;
    } finally {
      _guardando = false;
      notifyListeners();
    }
  }
}
