import 'package:flutter/material.dart';

class PageRecipe extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const PageRecipe({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/Home/${recipe['img']}',
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ingredients:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...recipe['bahan']
                      .map<Widget>((bahan) => Text('- $bahan'))
                      .toList(),
                  const SizedBox(height: 16),
                  const Text(
                    'Steps:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...recipe['step']
                      .map<Widget>((step) => Text('- $step'))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
