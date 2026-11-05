import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/ticket.dart';
import '../../providers/ticket_provider.dart';

class TicketFormPage extends StatefulWidget {
  const TicketFormPage({super.key});

  @override
  State<TicketFormPage> createState() => _TicketFormPageState();
}

class _TicketFormPageState extends State<TicketFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _clienteController = TextEditingController();
  final _asuntoController = TextEditingController();
  final _descripcionController = TextEditingController();

  CategoriaTicket _categoria = CategoriaTicket.sinServicio;

  @override
  void dispose() {
    _clienteController.dispose();
    _asuntoController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    final provider = context.read<TicketProvider>();

    if (provider.cargando || !_formKey.currentState!.validate()) {
      return;
    }

    final ahora = DateTime.now();
    final id = ahora.microsecondsSinceEpoch.toString();

    final ticket = Ticket(
      id: id,
      folio: 'TK-$id',
      cliente: _clienteController.text.trim(),
      asunto: _asuntoController.text.trim(),
      descripcion: _descripcionController.text.trim(),
      categoria: _categoria,
      fechaCreacion: ahora,
    );

    final guardado = await provider.registrar(ticket);

    if (!mounted) return;

    if (guardado) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.error ?? 'No se pudo guardar el ticket.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final estadoTickets = context.watch<TicketProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo ticket'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _clienteController,
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                ),
                validator: (valor) =>
                    valor == null || valor.trim().isEmpty
                        ? 'Completa este campo'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _asuntoController,
                decoration: const InputDecoration(
                  labelText: 'Asunto',
                ),
                validator: (valor) =>
                    valor == null || valor.trim().isEmpty
                        ? 'Completa este campo'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                ),
                validator: (valor) =>
                    valor == null || valor.trim().isEmpty
                        ? 'Completa este campo'
                        : null,
              ),
              const SizedBox(height: 16),
              const Text('Categoría'),
              DropdownButton<CategoriaTicket>(
                value: _categoria,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: CategoriaTicket.sinServicio,
                    child: Text('Sin servicio'),
                  ),
                  DropdownMenuItem(
                    value: CategoriaTicket.lentitud,
                    child: Text('Lentitud'),
                  ),
                  DropdownMenuItem(
                    value: CategoriaTicket.otro,
                    child: Text('Otro'),
                  ),
                ],
                onChanged: estadoTickets.cargando
                    ? null
                    : (valor) {
                        if (valor != null) {
                          setState(() => _categoria = valor);
                        }
                      },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: estadoTickets.cargando ? null : _guardar,
                  child: Text(
                    estadoTickets.cargando
                        ? 'Guardando...'
                        : 'Guardar ticket',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}