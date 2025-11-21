class Jadwal {
  int? id;
  String hari;
  String jam;
  String mataPelajaran;
  String guru;

  Jadwal({this.id, required this.hari, required this.jam, required this.mataPelajaran, required this.guru});

  factory Jadwal.fromMap(Map<String, dynamic> m) => Jadwal(
    id: m['id'],
    hari: m['hari'],
    jam: m['jam'],
    mataPelajaran: m['mata_pelajaran'],
    guru: m['guru'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'hari': hari,
    'jam': jam,
    'mata_pelajaran': mataPelajaran,
    'guru': guru,
  };
}
