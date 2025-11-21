import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/guru.dart';
import '../../providers/app_provider.dart';
import '../../widgets/simple_form_field.dart';

class GuruCrud extends StatefulWidget {
  const GuruCrud({super.key});
  @override
  State<GuruCrud> createState() => _GuruCrudState();
}

class _GuruCrudState extends State<GuruCrud> {
  final nipCtrl = TextEditingController();
  final namaCtrl = TextEditingController();
  final mapelCtrl = TextEditingController();
  Guru? editing;

  void save() async {
    final prov = Provider.of<AppProvider>(context, listen: false);
    final g = Guru(id: editing?.id, nip: nipCtrl.text, nama: namaCtrl.text, mataPelajaran: mapelCtrl.text);
    if (editing == null) {
      await prov.addGuru(g);
    } else {
      await prov.updateGuru(g);
    }
    clear();
  }

  void clear() { nipCtrl.clear(); namaCtrl.clear(); mapelCtrl.clear(); editing=null; setState((){}); }
  void edit(Guru g){ nipCtrl.text=g.nip; namaCtrl.text=g.nama; mapelCtrl.text=g.mataPelajaran; editing=g; setState((){}); }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Guru')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          SimpleFormField(controller: nipCtrl, label: 'NIP'),
          const SizedBox(height: 8),
          SimpleFormField(controller: namaCtrl, label: 'Nama'),
          const SizedBox(height: 8),
          SimpleFormField(controller: mapelCtrl, label: 'Mata Pelajaran'),
          const SizedBox(height: 8),
          Row(children: [
            ElevatedButton(onPressed: save, child: Text(editing==null? 'Tambah':'Update')),
            const SizedBox(width: 8),
            OutlinedButton(onPressed: clear, child: const Text('Bersihkan'))
          ]),
          const SizedBox(height: 12),
          Expanded(child: ListView.builder(itemCount: prov.guruList.length, itemBuilder: (context,i){
            final g=prov.guruList[i];
            return Card(
              child: ListTile(
                title: Text(g.nama),
                subtitle: Text('${g.nip} • ${g.mataPelajaran}'),
                trailing: Wrap(children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: ()=>edit(g)),
                  IconButton(icon: const Icon(Icons.delete), onPressed: ()=>prov.deleteGuru(g.id!)),
                ]),
              ),
            );
          }))
        ],),
      ),
    );
  }
}
