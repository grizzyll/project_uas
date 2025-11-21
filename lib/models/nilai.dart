class Nilai {
  int? id;
  int siswaId;
  String mataPelajaran;
  double tugas;
  double uts;
  double uas;

  Nilai({
    this.id,
    required this.siswaId,
    required this.mataPelajaran,
    required this.tugas,
    required this.uts,
    required this.uas,
  });

  double nilaiAkhir() {
    return tugas * 0.3 + uts * 0.3 + uas * 0.4;
  }

  String predikat() {
    final n = nilaiAkhir();
    if (n >= 85) return 'A';
    if (n >= 75) return 'B';
    if (n >= 65) return 'C';
    return 'D';
  }

  factory Nilai.fromMap(Map<String, dynamic> m) => Nilai(
    id: m['id'],
    siswaId: m['siswa_id'],
    mataPelajaran: m['mata_pelajaran'],
    tugas: (m['tugas'] as num).toDouble(),
    uts: (m['uts'] as num).toDouble(),
    uas: (m['uas'] as num).toDouble(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'siswa_id': siswaId,
    'mata_pelajaran': mataPelajaran,
    'tugas': tugas,
    'uts': uts,
    'uas': uas,
  };
}
