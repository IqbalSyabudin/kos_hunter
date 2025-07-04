class City {
  final int id;
  final String name;
  final String imageUrl;
  final bool isPopular;

  City({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isPopular = false,
  });
}
