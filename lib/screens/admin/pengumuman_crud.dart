import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // <--- INI YANG SEBELUMNYA KURANG
import '../../models/pengumuman.dart';
import '../../providers/app_provider.dart';

class PengumumanCrud extends StatefulWidget {
  const PengumumanCrud({super.key});

  @override
  State<PengumumanCrud> createState() => _PengumumanCrudState();
}

class _PengumumanCrudState extends State<PengumumanCrud> {
  
  // Fungsi untuk menampilkan Dialog Tambah Pengumuman
  void _showAddDialog() {
    final judulCtrl = TextEditingController();
    final isiCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Buat Pengumuman Baru"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: judulCtrl,
              decoration: const InputDecoration(
                labelText: "Judul Pengumuman",
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: isiCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Isi Pengumuman",
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (judulCtrl.text.isEmpty || isiCtrl.text.isEmpty) return;
              
              final prov = Provider.of<AppProvider>(context, listen: false);
              
              // Fix Error DateFormat disini
              final now = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()); 
              
              final p = Pengumuman(
                judul: judulCtrl.text, 
                isi: isiCtrl.text, 
                tanggal: now // Pastikan model Pengumuman punya field 'tanggal'
              );
              
              await prov.addPengumuman(p);
              if (!mounted) return;
              Navigator.pop(context); // Tutup dialog
            },
            child: const Text("Posting"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Pengumuman'),
      ),
      
      // Tombol Tambah Melayang (Modern UI Standard)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        icon: const Icon(Icons.add),
        label: const Text("Buat Baru"),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body: prov.pengumumanList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.campaign_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 10),
                  Text("Belum ada pengumuman", style: TextStyle(color: Colors.grey.shade500)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: prov.pengumumanList.length,
              itemBuilder: (context, i) {
                final p = prov.pengumumanList[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                p.judul,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 16
                                ),
                              ),
                            ),
                            // Tombol Hapus Kecil
                            InkWell(
                              onTap: () => prov.deletePengumuman(p.id!),
                              child: const Icon(Icons.delete_outline, color: Colors.red),
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Tampilkan Tanggal dengan warna abu-abu kecil
                        Text(
                          p.tanggal, // Pastikan ini string tanggal
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                        ),
                        const Divider(height: 20),
                        Text(
                          p.isi,
                          style: const TextStyle(fontSize: 14, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}