import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/auth_shell.dart';
import 'perfil_controller.dart';

class PerfilScreen extends StatefulWidget {
  final VoidCallback onGuardado;

  const PerfilScreen({
    super.key,
    required this.onGuardado,
  });

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final perfil = context.read<PerfilController>().perfil;
    _nombreController.text = perfil?.nombre ?? '';
    _correoController.text = perfil?.correo ?? '';
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    final controller = context.read<PerfilController>();

    if (controller.guardando) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    FocusScope.of(context).unfocus();

    final guardado = await controller.guardar(
      _nombreController.text,
      _correoController.text,
    );

    if (!mounted) return;

    if (guardado) {
      widget.onGuardado();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            controller.error ?? 'No se pudo guardar el perfil.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PerfilController>();
    final guardando = controller.guardando;
    final editando = controller.perfil != null;

    return AuthShell(
      title: editando ? 'MI PERFIL' : 'PERSONALIZA TU PERFIL',
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '¿Cómo te llamas?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tu nombre aparecerá en el panel de KoLine.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: _nombreController,
                enabled: !guardando,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Escribe tu nombre',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (valor) {
                  if ((valor ?? '').trim().length < 2) {
                    return 'Escribe al menos 2 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _correoController,
                enabled: !guardando,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autocorrect: false,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'nombre@ejemplo.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (valor) {
                  final correo = (valor ?? '').trim();
                  final valido = RegExp(
                    r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                  ).hasMatch(correo);

                  return valido ? null : 'Escribe un correo válido.';
                },
                onFieldSubmitted: (_) => _guardar(),
              ),
              const SizedBox(height: 28),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: cyan,
                  foregroundColor: navy,
                  disabledBackgroundColor: cyan.withValues(alpha: .3),
                  disabledForegroundColor: Colors.white70,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: guardando ? null : _guardar,
                child: Text(
                  guardando
                      ? 'GUARDANDO...'
                      : editando
                          ? 'GUARDAR CAMBIOS'
                          : 'GUARDAR Y CONTINUAR →',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (editando)
                TextButton(
                  onPressed: guardando
                      ? null
                      : () => Navigator.of(context).maybePop(),
                  child: const Text('Volver sin guardar'),
                ),
              const SizedBox(height: 18),
              const Text(
                'El perfil se conserva durante esta sesión.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}