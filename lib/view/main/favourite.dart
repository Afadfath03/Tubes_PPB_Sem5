import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Container untuk Favoritku dan Search Recipe
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.orange),
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
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.white),
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
                        child:
                            const Icon(Icons.filter_list, color: Colors.white),
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
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: const [
                    RecipeItem(
                      title: 'Nasi Goreng',
                      imagePath: 'assets/images/Favorite/nasi_goreng.png',
                      cookingTime: '10:00',
                    ),
                    RecipeItem(
                      title: 'Mie Nyemek',
                      imagePath: 'assets/images/Favorite/mie_nyemek.png',
                      cookingTime: '5:00',
                    ),
                    RecipeItem(
                      title: 'Tahu Cabe Garam',
                      imagePath: 'assets/images/Favorite/tahu_cabe_garam.png',
                      cookingTime: '5:00',
                    ),
                    RecipeItem(
                      title: 'Cah Kangkung',
                      imagePath: 'assets/images/Favorite/cak_kangkung.png',
                      cookingTime: '5:00',
                    ),
                    RecipeItem(
                      title: 'Sosis Telur Sambal',
                      imagePath: 'assets/images/Favorite/telur_sosis.png',
                      cookingTime: '5:00',
                    ),
                    RecipeItem(
                      title: 'Telur Orak Arik',
                      imagePath: 'assets/images/Favorite/telur_orak_arik.png',
                      cookingTime: '5:00',
                    ),
                  ],
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
  final String cookingTime;

  const RecipeItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.cookingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Row(
          children: [
            const Icon(Icons.timer, color: Colors.white54, size: 16),
            const SizedBox(width: 4),
            Text(cookingTime, style: const TextStyle(color: Colors.white54)),
          ],
        ),
        trailing: const Icon(Icons.favorite, color: Colors.orange),
      ),
    );
  }
}
