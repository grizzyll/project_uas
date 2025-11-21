import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_drawer.dart';
import '../../providers/app_provider.dart';
import 'input_nilai.dart';

class GuruDashboard extends StatelessWidget {
  const GuruDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Guru Dashboard')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Halo, ${prov.username ?? 'Guru'}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 12),

            // tombol input nilai
            ElevatedButton.icon(
              icon: const Icon(Icons.input),
              label: const Text('Input Nilai'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InputNilai(),
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            // tombol lihat pengumuman
            ElevatedButton.icon(
              icon: const Icon(Icons.announcement),
              label: const Text('Lihat Pengumuman'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: const Text('Pengumuman')),
                      body: const Center(
                        child: Text(
                          'Pergi ke menu Pengumuman di Dashboard Admin / Siswa',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
