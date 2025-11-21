import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/pengumuman.dart';
import '../../providers/app_provider.dart';
import '../../widgets/simple_form_field.dart';
import 'package:intl/intl.dart';

class PengumumanCrud extends StatefulWidget {
  const PengumumanCrud({super.key});
  @override
  State<PengumumanCrud> createState() => _PengumumanCrudState();
}

class _PengumumanCrudState extends State<PengumumanCrud> {
  final judulCtrl = TextEditingController();
  final isiCtrl = TextEditingController();

  void save() async {
    final prov = Provider.of<AppProvider>(context, listen: false);
    final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final p = Pengumuman(judul: judulCtrl.text, isi: isiCtrl.text, tanggal: now);
    await prov.addPengumuman(p);
    judulCtrl.clear(); isiCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Pengumuman')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          SimpleFormField(controller: judulCtrl, label: 'Judul'),
          const SizedBox(height: 8),
          TextField(controller: isiCtrl, maxLines: 4, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Isi')),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: save, child: const Text('Tambah Pengumuman')),
          const SizedBox(height: 12),
          Expanded(child: ListView.builder(itemCount: prov.pengumumanList.length, itemBuilder: (context, i){
            final p = prov.pengumumanList[i];
            return Card(
              child: ListTile(
                title: Text(p.judul),
                subtitle: Text(p.isi),
                trailing: IconButton(icon: const Icon(Icons.delete), onPressed: ()=>prov.deletePengumuman(p.id!)),
              ),
            );
          }))
        ]),
      ),
    );
  }
}
