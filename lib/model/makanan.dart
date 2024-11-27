class Makanan {
  final String name;
  final String image;
  final int rate;
  final bool isFavorite;

  Makanan(
      {required this.name,
      required this.image,
      required this.rate,
      this.isFavorite = false});
}
