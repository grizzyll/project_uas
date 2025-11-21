import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../models/nilai.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RaporScreen extends StatefulWidget {
  const RaporScreen({super.key});
  @override
  State<RaporScreen> createState() => _RaporScreenState();
}

class _RaporScreenState extends State<RaporScreen> {
  List<Nilai> nilaiList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadNilai();
  }

  Future<void> loadNilai() async {
    final prov = Provider.of<AppProvider>(context, listen: false);
    // find current siswa by username (dummy: username == nis)
    final sis = prov.siswaList.firstWhere((s) => s.nis == prov.username, orElse: ()=>prov.siswaList.isNotEmpty ? prov.siswaList.first : throw Exception('No siswa'));
    final rows = await DBService.instance.getNilaiBySiswa(sis.id!);
    setState(() { nilaiList = rows; loading = false; });
  }

  Future<void> exportPdf() async {
    final doc = pw.Document();
    doc.addPage(pw.MultiPage(
      build: (ctx) => [
        pw.Header(level: 0, child: pw.Text('Rapor Siswa')),
        pw.Table.fromTextArray(
          data: [
            ['Mata Pelajaran','Tugas','UTS','UAS','Nilai Akhir','Predikat'],
            ...nilaiList.map((n) => [
              n.mataPelajaran,
              n.tugas.toString(),
              n.uts.toString(),
              n.uas.toString(),
              n.nilaiAkhir().toStringAsFixed(2),
              n.predikat(),
            ])
          ]
        ),
      ],
    ));
    await Printing.layoutPdf(onLayout: (format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapor'),
        actions: [IconButton(icon: const Icon(Icons.picture_as_pdf), onPressed: exportPdf)],
      ),
      body: loading ? const Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Expanded(
            child: ListView.builder(itemCount: nilaiList.length, itemBuilder: (_, i) {
              final n = nilaiList[i];
              return Card(
                child: ListTile(
                  title: Text(n.mataPelajaran),
                  subtitle: Text('Tugas ${n.tugas} • UTS ${n.uts} • UAS ${n.uas}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(n.nilaiAkhir().toStringAsFixed(2)),
                      Text(n.predikat(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }),
          ),
        ]),
      ),
    );
  }
}
