import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../models/siswa.dart';
import '../../models/nilai.dart';
import '../../services/db_service.dart';

class InputNilai extends StatefulWidget {
  const InputNilai({super.key});

  @override
  State<InputNilai> createState() => _InputNilaiState();
}

class _InputNilaiState extends State<InputNilai> {
  Siswa? selected;
  final mapelCtrl = TextEditingController();
  final tugasCtrl = TextEditingController();
  final utsCtrl = TextEditingController();
  final uasCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Input Nilai')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            DropdownButton<Siswa>(
              hint: const Text("Pilih Siswa"),
              value: selected,
              isExpanded: true,
              items: prov.siswaList
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text("${s.nama} (${s.nis})"),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => selected = v),
            ),

            const SizedBox(height: 8),
            TextField(
              controller: mapelCtrl,
              decoration: const InputDecoration(
                labelText: 'Mata Pelajaran',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 8),
            TextField(
              controller: tugasCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tugas',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 8),
            TextField(
              controller: utsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'UTS',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 8),
            TextField(
              controller: uasCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'UAS',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                if (selected == null) return;

                final nilai = Nilai(
                  siswaId: selected!.id!,
                  mataPelajaran: mapelCtrl.text,
                  tugas: double.tryParse(tugasCtrl.text) ?? 0,
                  uts: double.tryParse(utsCtrl.text) ?? 0,
                  uas: double.tryParse(uasCtrl.text) ?? 0,
                );

                await DBService.instance.insertNilai(nilai);

                if (!mounted) return; // FIX PENTING

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Nilai berhasil disimpan!"),
                  ),
                );

                mapelCtrl.clear();
                tugasCtrl.clear();
                utsCtrl.clear();
                uasCtrl.clear();
              },
              child: const Text('Simpan Nilai'),
            ),
          ],
        ),
      ),
    );
  }
}
