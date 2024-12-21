import 'package:flutter/material.dart';
import 'package:tubes_ppb_sem5/view/main/see_all.dart';
import 'package:tubes_ppb_sem5/view/main/recommended.dart'; // Import halaman Recommended
import 'package:tubes_ppb_sem5/view/sidemenu.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SideMenu()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                RichText(
                  text: const TextSpan(
                    text: 'Selamat Datang ',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    children: [
                      TextSpan(
                        text: 'Aziz',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Mau masak apa kamu hari ini?',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search Recipe',
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.filter_list, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Today's Fresh Recipe",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PageSeeAll()),
                        );
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(color: Colors.orange, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 220, // Tinggi item diperbesar
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildRecipeCard(
                        title: 'Nasi Goreng',
                        image: 'assets/images/Home/nasi_goreng_di.png',
                        category: 'Breakfast',
                        duration: '15:00',
                      ),
                      _buildRecipeCard(
                        title: 'Cak Kangkung',
                        image: 'assets/images/Home/cak_kangkung.png',
                        category: 'Dinner',
                        duration: '30:00',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recommended",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PageRecommended()),
                        );
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(color: Colors.orange, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      _buildRecommendedCard(
                        title: 'Tahu Cabe Garam',
                        image: 'assets/images/Home/tahu_cabe_garam.png',
                        duration: '10:03',
                      ),
                      _buildRecommendedCard(
                        title: 'Telur Orak Arik',
                        image: 'assets/images/Home/telur_orak_arik.png',
                        duration: '05:00',
                      ),
                      _buildRecommendedCard(
                        title: 'Cak Kangkung',
                        image: 'assets/images/Home/cak_kangkung.png',
                        duration: '30:00',
                      ),
                      _buildRecommendedCard(
                        title: 'Mie Nyemek',
                        image: 'assets/images/Home/mie_nyemek.png',
                        duration: '15:00',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard({
    required String title,
    required String image,
    required String category,
    required String duration,
  }) {
    return Container(
      width: 180, // Lebar lebih besar agar lebih terekspose
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4), // Latar belakang semi-transparan
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4), // Warna bayangan transparan
            blurRadius: 6,
            offset: const Offset(0, 4), // Bayangan ke bawah
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(color: Colors.orange, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard({
    required String title,
    required String image,
    required String duration,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4), // Latar belakang semi-transparan
        borderRadius: BorderRadius.circular(20), // Sudut lebih melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4), // Shadow transparan
            blurRadius: 6, // Membuat bayangan lebih halus
            offset: const Offset(0, 4), // Bayangan ke bawah
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12), // Lengkung untuk gambar
            child: Image.asset(
              image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}