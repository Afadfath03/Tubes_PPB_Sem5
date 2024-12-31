class Recipe {
  final String name;
  final String image;
  final List<String> bahan;
  final List<String> step;

  Recipe({
    required this.name,
    required this.image,
    required this.bahan,
    required this.step,
  });

  factory Recipe.fromMap(Map<String, dynamic> data) {
    return Recipe(
      name: data['name'] ?? '',
      image: data['img'] ?? '',
      bahan: List<String>.from(data['bahan'] ?? []),
      step: List<String>.from(data['step'] ?? []),
    );
  }
}
