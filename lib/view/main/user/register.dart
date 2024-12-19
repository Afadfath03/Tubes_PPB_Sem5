import 'package:flutter/material.dart';
import 'package:tubes_ppb_sem5/view/main/user/login.dart';

class PageRegister extends StatelessWidget {
  const PageRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Transparent overlay
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Section
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/logo_chef.png',
                          height: 80,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "CHEF DADAKAN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Cook in easy way",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Input Fields
                    _buildInputField(
                      hintText: "Full Name",
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      hintText: "Email Address",
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      hintText: "Password",
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      hintText: "Confirm Password",
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 24),
                    // Register Button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Login Navigation
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PageLogin()),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Sudah punya akun? ",
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                              text: "Login Sekarang",
                              style: TextStyle(color: Colors.orange),
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
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: isPassword
            ? const Icon(Icons.visibility, color: Colors.white70)
            : null,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}