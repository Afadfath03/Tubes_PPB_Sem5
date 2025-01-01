import 'package:flutter/material.dart';
import 'package:tubes_ppb_sem5/services/database.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Map<String, dynamic>> favourites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFavourites();
  }

  Future<void> _fetchFavourites() async {
    DatabaseService dbService = DatabaseService();
    try {
      final data = await dbService.getFavourites();
      setState(() {
        favourites = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error jika diperlukan
      print('Error fetching favourites: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Container untuk Favorit dan Search Recipe
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.orange),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Favoritku',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white10,
                            hintText: 'Search Recipe',
                            hintStyle: const TextStyle(color: Colors.white54),
                            prefixIcon: const Icon(Icons.search, color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
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
                ],
              ),
            ),
            // Area ListView dengan background hitam
            Expanded(
              child: Container(
                color: Colors.black,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : favourites.isEmpty
                        ? const Center(
                            child: Text(
                              'No favourites found!',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: favourites.length,
                            itemBuilder: (context, index) {
                              final item = favourites[index];
                              return RecipeItem(
                                title: item['name'],
                                imagePath: 'assets/images/Favorite/${item['img']}', // Path lokal
                                bahan: item['bahan'],
                                step: item['step'],
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<String> bahan;
  final List<String> step;

  const RecipeItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.bahan,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath), // Menggunakan gambar lokal dari assets
        ),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Bahan:', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                ...bahan.map((b) => Text('- $b', style: const TextStyle(color: Colors.white))),
                const SizedBox(height: 8),
                const Text('Step:', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                ...step.map((s) => Text('- $s', style: const TextStyle(color: Colors.white))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}