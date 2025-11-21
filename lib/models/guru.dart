class Guru {
  int? id;
  String nip;
  String nama;
  String mataPelajaran;

  Guru({this.id, required this.nip, required this.nama, required this.mataPelajaran});

  factory Guru.fromMap(Map<String, dynamic> m) => Guru(
    id: m['id'],
    nip: m['nip'],
    nama: m['nama'],
    mataPelajaran: m['mata_pelajaran'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'nip': nip,
    'nama': nama,
    'mata_pelajaran': mataPelajaran,
  };
}
