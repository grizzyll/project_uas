import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../widgets/app_drawer.dart';
import 'siswa_crud.dart';
import 'guru_crud.dart';
import 'jadwal_crud.dart';
import 'pengumuman_crud.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Halo, ${prov.username ?? 'Admin'}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text('Kelola Siswa'),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SiswaCrud())),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.people),
                  label: const Text('Kelola Guru'),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GuruCrud())),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.schedule),
                  label: const Text('Kelola Jadwal'),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const JadwalCrud())),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.announcement),
                  label: const Text('Pengumuman'),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PengumumanCrud())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
