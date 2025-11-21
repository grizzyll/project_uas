import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../providers/app_provider.dart';
import '../models/user_role.dart';
import '../screens/admin/admin_dashboard.dart';
import '../screens/guru/guru_dashboard.dart';
import '../screens/siswa/siswa_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = AuthService();

  bool loading = false;
  String? error;

  Future<void> doLogin() async {
    setState(() {
      loading = true;
      error = null;
    });

    final role = await auth.login(
      userCtrl.text.trim(),
      passCtrl.text.trim(),
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return; // FIX PENTING

    if (role == null) {
      setState(() {
        error = 'User tidak ditemukan (pakai: admin / guru / siswa)';
      });
      return;
    }

    Provider.of<AppProvider>(context, listen: false)
        .setUser(userCtrl.text.trim(), role);

    Widget target;

    switch (role) {
      case UserRole.admin:
        target = const AdminDashboard();
        break;
      case UserRole.guru:
        target = const GuruDashboard();
        break;
      case UserRole.siswa:
        target = const SiswaDashboard();
        break;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => target),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: userCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 12),

            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),

            ElevatedButton(
              onPressed: loading ? null : doLogin,
              child: loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Login'),
            ),

            const SizedBox(height: 12),
            const Text('Dummy login: admin / guru / siswa (password bebas)')
          ],
        ),
      ),
    );
  }
}
