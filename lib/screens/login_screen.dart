import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required String selectedRole});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ... controller dan logic auth Anda tetap sama ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4F46E5), Color(0xFF818CF8)], // Gradient background
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo atau Icon Besar
                const Icon(Icons.school_rounded, size: 80, color: Colors.white),
                const SizedBox(height: 10),
                const Text(
                  "SIAKAD XYZ",
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 28, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 40),

                // Card Putih untuk Form
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Selamat Datang", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const Text("Silakan login untuk melanjutkan", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 30),
                        
                        TextFormField(
                          // controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: "Username", 
                            prefixIcon: Icon(Icons.person_outline)
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          // controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password", 
                            prefixIcon: Icon(Icons.lock_outline)
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Panggil fungsi login Anda di sini
                            },
                            child: const Text("MASUK", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}