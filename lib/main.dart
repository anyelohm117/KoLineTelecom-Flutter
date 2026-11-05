import 'package:flutter/material.dart';

const navy = Color(0xFF0A1D37);
const panel = Color(0xFF112240);
const cyan = Color(0xFF00EAFF);
const field = Color(0xFF0D213F);

void main() => runApp(const KoLineApp());

class KoLineApp extends StatelessWidget {
  const KoLineApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'KoLine Telecom', debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, brightness: Brightness.dark,
      scaffoldBackgroundColor: navy,
      colorScheme: ColorScheme.fromSeed(seedColor: cyan, brightness: Brightness.dark),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: field,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white24)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: cyan)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
      ),
    ),
    home: const LoginPage(),
  );
}

void go(BuildContext context, Widget destination) => Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
void notice(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Función pendiente en esta beta. Se implementará con datos locales en la Etapa 1.')));

class Backdrop extends StatelessWidget {
  final Widget child;
  const Backdrop({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
      colors: [navy, Color(0xFF051021), Colors.black])),
    child: Stack(children: [
      Positioned(top: -110, left: 30, child: _glow(cyan, 300)),
      Positioned(bottom: -140, right: -90, child: _glow(Colors.blue, 320)),
      child,
    ]),
  );
  Widget _glow(Color color, double size) => Container(width: size, height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: color.withValues(alpha: .13), blurRadius: 130, spreadRadius: 30)]));
}

class Brand extends StatelessWidget {
  const Brand({super.key});
  @override
  Widget build(BuildContext context) => Column(children: [
    Container(width: 110, height: 110, decoration: BoxDecoration(color: Colors.black38,
      shape: BoxShape.circle, border: Border.all(color: cyan.withValues(alpha: .5)),
      boxShadow: [BoxShadow(color: cyan.withValues(alpha: .25), blurRadius: 25)]),
      child: const Icon(Icons.hub_outlined, color: cyan, size: 53)),
    const SizedBox(height: 20),
    const Text.rich(TextSpan(children: [TextSpan(text: 'KoLine ', style: TextStyle(color: Colors.white)),
      TextSpan(text: 'Telecom', style: TextStyle(color: cyan))]), style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold)),
    const SizedBox(height: 7),
    const Text('ACCESO A LA RED', style: TextStyle(fontSize: 12, letterSpacing: 3, color: Colors.white54)),
  ]);
}

class AccentButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const AccentButton({super.key, required this.label, required this.onPressed});
  @override
  Widget build(BuildContext context) => SizedBox(width: double.infinity, height: 52, child: FilledButton(
    style: FilledButton.styleFrom(backgroundColor: cyan, foregroundColor: navy,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    onPressed: onPressed, child: Text(label.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1))));
}

class AuthShell extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const AuthShell({super.key, required this.title, required this.children});
  @override
  Widget build(BuildContext context) => Scaffold(body: Backdrop(child: SafeArea(child: Center(child:
    SingleChildScrollView(padding: const EdgeInsets.all(20), child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 455),
      child: Container(padding: const EdgeInsets.all(32), decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .08), borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white12), boxShadow: [BoxShadow(color: cyan.withValues(alpha: .07), blurRadius: 45)]),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Brand(), const SizedBox(height: 26),
          if (title.isNotEmpty) ...[Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700)), const SizedBox(height: 18)],
          ...children,
        ]),
      )),
    )))));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool obscured = true;
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AuthShell(title: '', children: [
    Form(key: formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const _Label('CORREO ELECTRÓNICO'),
      TextFormField(controller: email, keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(prefixIcon: Icon(Icons.email_outlined), hintText: 'usuario@koline.com'),
        validator: (v) => v == null || !v.contains('@') ? 'Introduce un correo válido' : null),
      const SizedBox(height: 20),
      const _Label('CONTRASEÑA'),
      TextFormField(controller: password, obscureText: obscured,
        decoration: InputDecoration(prefixIcon: const Icon(Icons.lock_outline), hintText: '••••••••',
          suffixIcon: IconButton(icon: Icon(obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined),
            onPressed: () => setState(() => obscured = !obscured))),
        validator: (v) => v == null || v.isEmpty ? 'Introduce la contraseña' : null),
      const SizedBox(height: 25),
      AccentButton(label: 'Iniciar sesión →', onPressed: () { if (formKey.currentState!.validate()) go(context, const HomePage(admin: true)); }),
    ])),
    const SizedBox(height: 20), const Divider(color: Colors.white12),
    Wrap(alignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, children: [
      const Text('¿No tienes cuenta?', style: TextStyle(color: Colors.white60)),
      TextButton(onPressed: () => go(context, const RegisterPage()), child: const Text('Regístrate aquí', style: TextStyle(color: cyan))),
    ]),
    TextButton(onPressed: () => go(context, const RecoveryPage()), child: const Text('Olvidé mi contraseña', style: TextStyle(color: Colors.white54))),
    const SizedBox(height: 8),
    const Text('DEMO: cualquier correo válido y contraseña abren el panel visual.',
      textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 11)),
  ]);
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 9),
    child: Text(text, style: const TextStyle(color: cyan, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)));
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) => AuthShell(title: 'Crear cuenta', children: [
    const TextField(decoration: InputDecoration(labelText: 'Nombre completo', prefixIcon: Icon(Icons.person_outline))),
    const SizedBox(height: 14),
    const TextField(decoration: InputDecoration(labelText: 'Correo electrónico', prefixIcon: Icon(Icons.email_outlined))),
    const SizedBox(height: 14),
    const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Contraseña', prefixIcon: Icon(Icons.lock_outline))),
    const SizedBox(height: 20), AccentButton(label: 'Registrarme', onPressed: () => notice(context)),
    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Volver al inicio de sesión')),
  ]);
}
class RecoveryPage extends StatelessWidget {
  const RecoveryPage({super.key});
  @override
  Widget build(BuildContext context) => AuthShell(title: 'Recuperar contraseña', children: [
    const Text('Introduce tu correo para recuperar el acceso.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
    const SizedBox(height: 18),
    const TextField(decoration: InputDecoration(labelText: 'Correo electrónico', prefixIcon: Icon(Icons.email_outlined))),
    const SizedBox(height: 20), AccentButton(label: 'Enviar instrucciones', onPressed: () => notice(context)),
    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Regresar')),
  ]);
}

class HomePage extends StatefulWidget {
  final bool admin;
  const HomePage({super.key, required this.admin});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int selected = 0;
  late bool admin = widget.admin;
  final items = const [
    (Icons.dashboard_outlined, 'Resumen'),
    (Icons.people_alt_outlined, 'Usuarios'),
    (Icons.receipt_long_outlined, 'Tickets'),
    (Icons.settings_outlined, 'Configuración'),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(backgroundColor: panel, title: const Text.rich(TextSpan(children: [
      TextSpan(text: 'KoLine '), TextSpan(text: 'Telecom', style: TextStyle(color: cyan))])),
      actions: [
        PopupMenuButton<String>(icon: const Icon(Icons.account_circle_outlined), onSelected: (v) {
          if (v == 'salir') Navigator.popUntil(context, (r) => r.isFirst);
          if (v == 'clave') go(context, const PasswordPage());
          if (v == 'rol') setState(() => admin = !admin);
        }, itemBuilder: (_) => [
          PopupMenuItem(value: 'rol', child: Text('Vista ${admin ? 'cliente' : 'administrador'}')),
          const PopupMenuItem(value: 'clave', child: Text('Cambiar contraseña')),
          const PopupMenuItem(value: 'salir', child: Text('Cerrar sesión')),
        ]),
      ],
    ),
    body: LayoutBuilder(builder: (context, size) => Row(children: [
      if (size.maxWidth > 750) SizedBox(width: 230, child: Container(color: panel,
        child: Column(children: [const SizedBox(height: 25), Text(admin ? 'ADMINISTRACIÓN' : 'PORTAL CLIENTE', style: const TextStyle(color: cyan, fontWeight: FontWeight.bold)),
          const SizedBox(height: 22), for (var i = 0; i < items.length; i++) ListTile(
            selected: selected == i, selectedColor: cyan, leading: Icon(items[i].$1), title: Text(items[i].$2),
            onTap: () => setState(() => selected = i)),
        ]))),
      Expanded(child: Backdrop(child: SingleChildScrollView(padding: const EdgeInsets.all(25),
        child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1100), child: _content())))),
    ])),
    bottomNavigationBar: MediaQuery.sizeOf(context).width <= 750 ? NavigationBar(
      selectedIndex: selected, onDestinationSelected: (v) => setState(() => selected = v),
      destinations: [for (final item in items) NavigationDestination(icon: Icon(item.$1), label: item.$2)]) : null,
  );

  Widget _content() {
    if (selected == 3) return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const _Heading('Configuración', 'Preferencias de usuario'), const SizedBox(height: 15),
      _Card(child: Column(children: [
        const TextField(decoration: InputDecoration(labelText: 'Nombre visible')),
        const SizedBox(height: 15),
        const TextField(decoration: InputDecoration(labelText: 'Correo')),
        const SizedBox(height: 20), AccentButton(label: 'Guardar cambios', onPressed: () => notice(context)),
      ])),
    ]);
    if (selected == 1 || selected == 2) return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _Heading(selected == 1 ? 'Usuarios' : 'Tickets', 'Consulta de registros • datos de demostración'),
      const SizedBox(height: 18),
      _Card(child: Column(children: [
        TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: selected == 1 ? 'Buscar usuarios' : 'Buscar tickets')),
        const SizedBox(height: 12),
        for (int i = 0; i < 4; i++) ListTile(
          leading: CircleAvatar(backgroundColor: cyan.withValues(alpha: .12), child: Icon(selected == 1 ? Icons.person : Icons.confirmation_number, color: cyan)),
          title: Text(selected == 1 ? 'Usuario de ejemplo ${i + 1}' : 'Ticket de ejemplo #${101 + i}'),
          subtitle: const Text('Contenido ilustrativo, no obtenido de MySQL'),
          trailing: const Icon(Icons.chevron_right), onTap: () => notice(context),
        ),
      ])),
    ]);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _Heading('Bienvenido al panel ${admin ? 'administrativo' : 'de cliente'}', 'Visión general de KoLine Telecom'),
      const SizedBox(height: 10),
      const Text('Vista de demostración • las cifras no provienen de la base de datos', style: TextStyle(color: Colors.white54, fontSize: 12)),
      const SizedBox(height: 24),
      Wrap(spacing: 16, runSpacing: 16, children: [
        _Metric(icon: Icons.people_outline, title: 'Usuarios', value: '—'),
        _Metric(icon: Icons.support_agent, title: 'Tickets abiertos', value: '—'),
        _Metric(icon: Icons.wifi, title: 'Servicios', value: '—'),
        _Metric(icon: Icons.monitor_heart_outlined, title: 'Estado de red', value: 'Sin conexión'),
      ]),
      const SizedBox(height: 22),
      _Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Acciones rápidas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(spacing: 10, runSpacing: 10, children: [
          OutlinedButton.icon(onPressed: () => setState(() => selected = 1), icon: const Icon(Icons.people_outline), label: const Text('Ver usuarios')),
          OutlinedButton.icon(onPressed: () => setState(() => selected = 2), icon: const Icon(Icons.receipt_long), label: const Text('Ver tickets')),
          OutlinedButton.icon(onPressed: () => setState(() => admin = !admin), icon: const Icon(Icons.swap_horiz), label: const Text('Cambiar vista de rol')),
        ]),
      ])),
    ]);
  }
}

class _Heading extends StatelessWidget {
  final String title, subtitle;
  const _Heading(this.title, this.subtitle);
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
    const SizedBox(height: 5), Text(subtitle, style: const TextStyle(color: Colors.white60)),
  ]);
}
class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(color: panel.withValues(alpha: .92), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white12)), child: child);
}
class _Metric extends StatelessWidget {
  final IconData icon;
  final String title, value;
  const _Metric({required this.icon, required this.title, required this.value});
  @override
  Widget build(BuildContext context) => SizedBox(width: 225, child: _Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, color: cyan, size: 28), const SizedBox(height: 17),
    Text(title, style: const TextStyle(color: Colors.white60)), const SizedBox(height: 6),
    Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
  ])));
}
class PasswordPage extends StatelessWidget {
  const PasswordPage({super.key});
  @override
  Widget build(BuildContext context) => AuthShell(title: 'Cambiar contraseña', children: [
    const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Contraseña actual')),
    const SizedBox(height: 15), const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Contraseña nueva')),
    const SizedBox(height: 15), const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Confirmar contraseña')),
    const SizedBox(height: 20), AccentButton(label: 'Actualizar contraseña', onPressed: () => notice(context)),
    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Volver')),
  ]);
}
