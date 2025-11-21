import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/siswa.dart';
import '../../providers/app_provider.dart';
import '../../widgets/simple_form_field.dart';

class SiswaCrud extends StatefulWidget {
  const SiswaCrud({super.key});
  @override
  State<SiswaCrud> createState() => _SiswaCrudState();
}

class _SiswaCrudState extends State<SiswaCrud> {
  final nisCtrl = TextEditingController();
  final namaCtrl = TextEditingController();
  final kelasCtrl = TextEditingController();
  final jurusanCtrl = TextEditingController();
  Siswa? editing;

  void save() async {
    final prov = Provider.of<AppProvider>(context, listen: false);
    final s = Siswa(
      id: editing?.id,
      nis: nisCtrl.text,
      nama: namaCtrl.text,
      kelas: kelasCtrl.text,
      jurusan: jurusanCtrl.text,
    );
    if (editing == null) {
      await prov.addSiswa(s);
    } else {
      await prov.updateSiswa(s);
    }
    clearForm();
  }

  void clearForm() {
    nisCtrl.clear(); namaCtrl.clear(); kelasCtrl.clear(); jurusanCtrl.clear();
    editing = null;
    setState(() {});
  }

  void edit(Siswa s) {
    nisCtrl.text = s.nis;
    namaCtrl.text = s.nama;
    kelasCtrl.text = s.kelas;
    jurusanCtrl.text = s.jurusan;
    editing = s;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Siswa')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SimpleFormField(controller: nisCtrl, label: 'NIS'),
            const SizedBox(height: 8),
            SimpleFormField(controller: namaCtrl, label: 'Nama'),
            const SizedBox(height: 8),
            SimpleFormField(controller: kelasCtrl, label: 'Kelas'),
            const SizedBox(height: 8),
            SimpleFormField(controller: jurusanCtrl, label: 'Jurusan'),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(onPressed: save, child: Text(editing==null? 'Tambah':'Update')),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: clearForm, child: const Text('Bersihkan')),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: prov.siswaList.length,
                itemBuilder: (context, i) {
                  final s = prov.siswaList[i];
                  return Card(
                    child: ListTile(
                      title: Text(s.nama),
                      subtitle: Text('${s.nis} • ${s.kelas}'),
                      trailing: Wrap(
                        children: [
                          IconButton(icon: const Icon(Icons.edit), onPressed: () => edit(s)),
                          IconButton(icon: const Icon(Icons.delete), onPressed: () => prov.deleteSiswa(s.id!)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
