import 'package:flutter/material.dart';
import 'package:tubes_ppb_sem5/services/database.dart';
import 'package:tubes_ppb_sem5/services/user_data.dart';

import 'package:tubes_ppb_sem5/view/main/recipe.dart';
import 'package:tubes_ppb_sem5/view/sidemenu.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  late final dynamic userData;
  List<Map<String, dynamic>> makanan = [];
  bool isLoading = true;
  String namaUser = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    // Fetch user data
    UserData userDataService = UserData();
    await userDataService.fetchUserData();
    userData = userDataService.userData;

    // Fetch makanan data
    DatabaseService dbService = DatabaseService();
    final data = await dbService.getMakanan();

    // Update state
    setState(() {
      makanan = data;
      namaUser = userData['nickname'];
      isLoading = false;
    });
  }

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
                          MaterialPageRoute(builder: (context) => SideMenu()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Selamat Datang ',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    children: [
                      TextSpan(
                        text: namaUser,
                        style: const TextStyle(
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
                const SizedBox(height: 24),
                const Text(
                  "Today's Fresh Recipe",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 16),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: makanan.length,
                          itemBuilder: (context, index) {
                            final item = makanan[index];
                            return _buildRecipeCard(item);
                          },
                        ),
                      ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageRecipe(recipe: item),
          ),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 4),
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
                'assets/images/Home/${item['img']}',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'Image not found',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Breakfast', // Placeholder kategori
                    style: TextStyle(color: Colors.orange, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['name'],
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
                      const Text(
                        '15:00', // Placeholder durasi
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
