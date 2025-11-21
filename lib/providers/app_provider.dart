import 'package:flutter/material.dart';
import '../models/user_role.dart';
import '../models/siswa.dart';
import '../models/guru.dart';
import '../models/jadwal.dart';
import '../models/pengumuman.dart';

class AppProvider extends ChangeNotifier {
  UserRole? _role;
  String? _username;
  List<Siswa> siswaList = [];
  List<Guru> guruList = [];
  List<Jadwal> jadwalList = [];
  List<Pengumuman> pengumumanList = [];

  UserRole? get role => _role;
  String? get username => _username;

  void setUser(String username, UserRole role) {
    _username = username;
    _role = role;
    notifyListeners();
    loadAll();
  }

  void logout() {
    _username = null;
    _role = null;
    notifyListeners();
  }

  Future<void> loadAll() async {
    siswaList = await DBService.instance.getAllSiswa();
    guruList = await DBService.instance.getAllGuru();
    jadwalList = await DBService.instance.getAllJadwal();
    pengumumanList = await DBService.instance.getAllPengumuman();
    notifyListeners();
  }

  // CRUD helpers with DBService, call loadAll after modifications
  Future addSiswa(Siswa s) async {
    await DBService.instance.insertSiswa(s);
    await loadAll();
  }
  Future updateSiswa(Siswa s) async {
    await DBService.instance.updateSiswa(s);
    await loadAll();
  }
  Future deleteSiswa(int id) async {
    await DBService.instance.deleteSiswa(id);
    await loadAll();
  }

  Future addGuru(Guru g) async {
    await DBService.instance.insertGuru(g);
    await loadAll();
  }
  Future updateGuru(Guru g) async {
    await DBService.instance.updateGuru(g);
    await loadAll();
  }
  Future deleteGuru(int id) async {
    await DBService.instance.deleteGuru(id);
    await loadAll();
  }

  Future addJadwal(Jadwal j) async {
    await DBService.instance.insertJadwal(j);
    await loadAll();
  }
  Future updateJadwal(Jadwal j) async {
    await DBService.instance.updateJadwal(j);
    await loadAll();
  }
  Future deleteJadwal(int id) async {
    await DBService.instance.deleteJadwal(id);
    await loadAll();
  }

  Future addPengumuman(Pengumuman p) async {
    await DBService.instance.insertPengumuman(p);
    await loadAll();
  }
  Future deletePengumuman(int id) async {
    await DBService.instance.deletePengumuman(id);
    await loadAll();
  }
}

class DBService {
  static get instance => null;
}
