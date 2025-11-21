class Pengumuman {
  int? id;
  String judul;
  String isi;
  String tanggal; // ISO string

  Pengumuman({this.id, required this.judul, required this.isi, required this.tanggal});

  factory Pengumuman.fromMap(Map<String,dynamic> m) => Pengumuman(
    id: m['id'],
    judul: m['judul'],
    isi: m['isi'],
    tanggal: m['tanggal'],
  );

  Map<String,dynamic> toMap() => {
    'id': id,
    'judul': judul,
    'isi': isi,
    'tanggal': tanggal,
  };
}
