import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/siswa.dart';
import '../models/guru.dart';
import '../models/jadwal.dart';
import '../models/nilai.dart';
import '../models/pengumuman.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBService {
  DBService._privateConstructor();
  static final DBService instance = DBService._privateConstructor();

  static Database? _db;

  Future<void> init() async {
    if (_db != null) return;
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'felisitas_uas.db');
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE siswa (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nis TEXT,
        nama TEXT,
        kelas TEXT,
        jurusan TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE guru (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nip TEXT,
        nama TEXT,
        mata_pelajaran TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE jadwal (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        hari TEXT,
        jam TEXT,
        mata_pelajaran TEXT,
        guru TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE nilai (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        siswa_id INTEGER,
        mata_pelajaran TEXT,
        tugas REAL,
        uts REAL,
        uas REAL
      )
    ''');
    await db.execute('''
      CREATE TABLE pengumuman (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT,
        isi TEXT,
        tanggal TEXT
      )
    ''');
    // insert sample data (optional)
    await db.insert('guru', {'nip': 'G001', 'nama': 'Budi', 'mata_pelajaran': 'Matematika'});
    await db.insert('siswa', {'nis': 'S001', 'nama': 'Ani', 'kelas': '10A', 'jurusan': 'IPA'});
  }

  Database get db => _db!;

  // --- Siswa CRUD ---
  Future<int> insertSiswa(Siswa s) => db.insert('siswa', s.toMap());
  Future<List<Siswa>> getAllSiswa() async {
    final rows = await db.query('siswa', orderBy: 'nama');
    return rows.map((r) => Siswa.fromMap(r)).toList();
  }
  Future<int> updateSiswa(Siswa s) => db.update('siswa', s.toMap(), where: 'id=?', whereArgs: [s.id]);
  Future<int> deleteSiswa(int id) => db.delete('siswa', where: 'id=?', whereArgs: [id]);

  // --- Guru CRUD ---
  Future<int> insertGuru(Guru g) => db.insert('guru', g.toMap());
  Future<List<Guru>> getAllGuru() async {
    final rows = await db.query('guru', orderBy: 'nama');
    return rows.map((r) => Guru.fromMap(r)).toList();
  }
  Future<int> updateGuru(Guru g) => db.update('guru', g.toMap(), where: 'id=?', whereArgs: [g.id]);
  Future<int> deleteGuru(int id) => db.delete('guru', where: 'id=?', whereArgs: [id]);

  // --- Jadwal CRUD ---
  Future<int> insertJadwal(Jadwal j) => db.insert('jadwal', j.toMap());
  Future<List<Jadwal>> getAllJadwal() async {
    final rows = await db.query('jadwal', orderBy: 'hari, jam');
    return rows.map((r) => Jadwal.fromMap(r)).toList();
  }
  Future<int> updateJadwal(Jadwal j) => db.update('jadwal', j.toMap(), where: 'id=?', whereArgs: [j.id]);
  Future<int> deleteJadwal(int id) => db.delete('jadwal', where: 'id=?', whereArgs: [id]);

  // --- Nilai CRUD ---
  Future<int> insertNilai(Nilai n) => db.insert('nilai', n.toMap());
  Future<List<Nilai>> getNilaiBySiswa(int siswaId) async {
    final rows = await db.query('nilai', where: 'siswa_id=?', whereArgs: [siswaId]);
    return rows.map((r) => Nilai.fromMap(r)).toList();
  }
  Future<int> updateNilai(Nilai n) => db.update('nilai', n.toMap(), where: 'id=?', whereArgs: [n.id]);
  Future<int> deleteNilai(int id) => db.delete('nilai', where: 'id=?', whereArgs: [id]);

  // --- Pengumuman CRUD ---
  Future<int> insertPengumuman(Pengumuman p) => db.insert('pengumuman', p.toMap());
  Future<List<Pengumuman>> getAllPengumuman() async {
    final rows = await db.query('pengumuman', orderBy: 'tanggal DESC');
    return rows.map((r) => Pengumuman.fromMap(r)).toList();
  }
  Future<int> deletePengumuman(int id) => db.delete('pengumuman', where: 'id=?', whereArgs: [id]);
}
