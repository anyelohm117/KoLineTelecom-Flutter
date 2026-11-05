/// Contiene los datos básicos del perfil guardados localmente.
class PerfilLocal {
  /// Nombre asociado al perfil.
  final String nombre;

  /// Dirección de correo electrónico asociada al perfil.
  final String correo;

  /// Crea un perfil local con nombre y correo obligatorios.
  const PerfilLocal({
    required this.nombre,
    required this.correo,
  });
}
