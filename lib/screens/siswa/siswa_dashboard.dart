import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../widgets/app_drawer.dart';
import 'rapor_screen.dart';

class SiswaDashboard extends StatelessWidget {
  const SiswaDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Siswa Dashboard')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text('Halo, ${prov.username ?? 'Siswa'}', style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.receipt_long),
            label: const Text('Lihat Rapor'),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RaporScreen())),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.announcement),
            label: const Text('Pengumuman'),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Pengumuman')),
              body: Consumer<AppProvider>(builder: (context, prov2, _) {
                return ListView.builder(itemCount: prov2.pengumumanList.length, itemBuilder: (_,i){
                  final p = prov2.pengumumanList[i];
                  return ListTile(title: Text(p.judul), subtitle: Text(p.isi));
                });
              }),
            ))),
          ),
        ]),
      ),
    );
  }
}
