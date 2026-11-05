import '../models/perfil_local.dart';
import '../models/perfil_repository.dart';

/// Repositorio en memoria para consultar y guardar un perfil local.
class PerfilRepositoryLocal implements PerfilRepository {
  /// Perfil guardado durante la vida de esta instancia.
  PerfilLocal? _perfil;

  /// Devuelve el perfil guardado o `null` si todavía no hay uno.
  @override
  Future<PerfilLocal?> leer() async => _perfil;

  /// Valida y guarda el perfil con espacios externos eliminados.
  ///
  /// Lanza [ArgumentError] si el nombre tiene menos de dos caracteres o el
  /// correo no tiene un formato válido.
  @override
  Future<void> guardar(PerfilLocal perfil) async {
    final nombre = perfil.nombre.trim();
    final correo = perfil.correo.trim();
    final correoValido = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    if (nombre.length < 2 || !correoValido.hasMatch(correo)) {
      throw ArgumentError('Introduce un nombre y un correo válidos.');
    }

    _perfil = PerfilLocal(nombre: nombre, correo: correo);
  }
}
