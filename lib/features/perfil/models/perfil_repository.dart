import '../models/perfil_local.dart';

abstract class PerfilRepository {
  Future<PerfilLocal?> leer();
  Future<void> guardar(PerfilLocal perfil);
}
