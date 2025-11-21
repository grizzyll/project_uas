import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('siakad_final.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Tabel User
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        role TEXT
      )
    ''');

    // Tabel Siswa
    await db.execute('''
      CREATE TABLE siswa (
        nis TEXT PRIMARY KEY,
        nama TEXT,
        kelas TEXT,
        jurusan TEXT
      )
    ''');

    // Tabel Nilai
    await db.execute('''
      CREATE TABLE nilai (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nis_siswa TEXT,
        mata_pelajaran TEXT,
        tugas REAL,
        uts REAL,
        uas REAL,
        FOREIGN KEY (nis_siswa) REFERENCES siswa (nis)
      )
    ''');

    // INSERT DUMMY DATA (Agar bisa langsung login)
    await db.insert('users', {'username': 'admin', 'password': '123', 'role': 'admin'});
    await db.insert('users', {'username': 'guru', 'password': '123', 'role': 'guru'});
    await db.insert('users', {'username': 'siswa', 'password': '123', 'role': 'siswa'}); // Username siswa pakai NIS nanti di real case
    
    // Dummy Siswa untuk User Siswa
    await db.insert('siswa', {'nis': '12345', 'nama': 'Budi Santoso', 'kelas': '12 RPL', 'jurusan': 'RPL'});
  }

  // CRUD Helpers
  Future<List<Map<String, dynamic>>> getAllSiswa() async {
    final db = await instance.database;
    return await db.query('siswa');
  }

  Future<int> insertSiswa(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('siswa', row);
  }

  Future<int> updateNilai(Map<String, dynamic> row) async {
    final db = await instance.database;
    // Cek apakah nilai mapel ini sudah ada
    final cek = await db.query('nilai', 
      where: 'nis_siswa = ? AND mata_pelajaran = ?', 
      whereArgs: [row['nis_siswa'], row['mata_pelajaran']]);
    
    if (cek.isEmpty) {
      return await db.insert('nilai', row);
    } else {
      return await db.update('nilai', row, 
        where: 'nis_siswa = ? AND mata_pelajaran = ?',
        whereArgs: [row['nis_siswa'], row['mata_pelajaran']]);
    }
  }

  Future<List<Map<String, dynamic>>> getNilaiByNis(String nis) async {
    final db = await instance.database;
    return await db.query('nilai', where: 'nis_siswa = ?', whereArgs: [nis]);
  }
}