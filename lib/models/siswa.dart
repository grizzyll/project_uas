class Siswa {
  int? id;
  String nis;
  String nama;
  String kelas;
  String jurusan;

  Siswa({this.id, required this.nis, required this.nama, required this.kelas, required this.jurusan});

  factory Siswa.fromMap(Map<String, dynamic> m) => Siswa(
    id: m['id'],
    nis: m['nis'],
    nama: m['nama'],
    kelas: m['kelas'],
    jurusan: m['jurusan'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'nis': nis,
    'nama': nama,
    'kelas': kelas,
    'jurusan': jurusan,
  };
}
