import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(icon: const Icon(Icons.logout, color: Colors.red), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Sapaan
            const Text(
              "Halo, Admin!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text("Kelola data sekolah dengan mudah.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),

            // Grid Menu
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 kolom
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context, 
                    title: "Data Siswa", 
                    icon: Icons.people_alt_rounded, 
                    color: Colors.blue,
                    onTap: () { /* Navigasi ke CRUD Siswa */ }
                  ),
                  _buildMenuCard(
                    context, 
                    title: "Data Guru", 
                    icon: Icons.person_pin_rounded, 
                    color: Colors.orange,
                    onTap: () { /* Navigasi ke CRUD Guru */ }
                  ),
                  _buildMenuCard(
                    context, 
                    title: "Jadwal", 
                    icon: Icons.calendar_today_rounded, 
                    color: Colors.green,
                    onTap: () { /* Navigasi ke Jadwal */ }
                  ),
                  _buildMenuCard(
                    context, 
                    title: "Pengumuman", 
                    icon: Icons.campaign_rounded, 
                    color: Colors.purple,
                    onTap: () { /* Navigasi ke Pengumuman */ }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Card Menu yang Cantik
  Widget _buildMenuCard(BuildContext context, {required String title, required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}