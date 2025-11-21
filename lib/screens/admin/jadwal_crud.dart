import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/jadwal.dart';
import '../../providers/app_provider.dart';
import '../../widgets/simple_form_field.dart';

class JadwalCrud extends StatefulWidget {
  const JadwalCrud({super.key});
  @override
  State<JadwalCrud> createState() => _JadwalCrudState();
}

class _JadwalCrudState extends State<JadwalCrud> {
  final hariCtrl = TextEditingController();
  final jamCtrl = TextEditingController();
  final mapelCtrl = TextEditingController();
  final guruCtrl = TextEditingController();
  Jadwal? editing;

  void save() async {
    final prov = Provider.of<AppProvider>(context, listen: false);
    final j = Jadwal(id: editing?.id, hari: hariCtrl.text, jam: jamCtrl.text, mataPelajaran: mapelCtrl.text, guru: guruCtrl.text);
    if (editing == null) {
      await prov.addJadwal(j);
    } else {
      await prov.updateJadwal(j);
    }
    clear();
  }

  void clear() { hariCtrl.clear(); jamCtrl.clear(); mapelCtrl.clear(); guruCtrl.clear(); editing=null; setState((){}); }
  void edit(Jadwal j){ hariCtrl.text=j.hari; jamCtrl.text=j.jam; mapelCtrl.text=j.mataPelajaran; guruCtrl.text=j.guru; editing=j; setState((){}); }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Jadwal')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          SimpleFormField(controller: hariCtrl, label: 'Hari'),
          const SizedBox(height: 8),
          SimpleFormField(controller: jamCtrl, label: 'Jam'),
          const SizedBox(height: 8),
          SimpleFormField(controller: mapelCtrl, label: 'Mata Pelajaran'),
          const SizedBox(height: 8),
          SimpleFormField(controller: guruCtrl, label: 'Guru Pengampu'),
          const SizedBox(height: 8),
          Row(children: [
            ElevatedButton(onPressed: save, child: Text(editing==null? 'Tambah':'Update')),
            const SizedBox(width: 8),
            OutlinedButton(onPressed: clear, child: const Text('Bersihkan'))
          ]),
          const SizedBox(height: 12),
          Expanded(child: ListView.builder(itemCount: prov.jadwalList.length, itemBuilder: (context,i){
            final j=prov.jadwalList[i];
            return Card(
              child: ListTile(
                title: Text('${j.hari} ${j.jam} - ${j.mataPelajaran}'),
                subtitle: Text(j.guru),
                trailing: Wrap(children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: ()=>edit(j)),
                  IconButton(icon: const Icon(Icons.delete), onPressed: ()=>prov.deleteJadwal(j.id!)),
                ]),
              ),
            );
          }))
        ]),
      ),
    );
  }
}
