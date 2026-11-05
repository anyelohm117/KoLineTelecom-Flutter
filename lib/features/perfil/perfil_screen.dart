import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final guardando = context.watch<PerfilController>().guardando;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.person_outline, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    'Completa tu perfil',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Usaremos tu nombre para personalizar el panel.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nombreController,
                    enabled: !guardando,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (valor) {
                      if ((valor ?? '').trim().length < 2) {
                        return 'Escribe un nombre de al menos 2 caracteres.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _correoController,
                    enabled: !guardando,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (valor) {
                      final correo = (valor ?? '').trim();
                      final valido = RegExp(
                        r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                      ).hasMatch(correo);

                      return valido
                          ? null
                          : 'Escribe un correo electrónico válido.';
                    },
                    onFieldSubmitted: (_) => _guardar(),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: guardando ? null : _guardar,
                    child: Text(
                      guardando ? 'Guardando...' : 'Guardar perfil',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'El perfil se conserva durante esta sesión.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
