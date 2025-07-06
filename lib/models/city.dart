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

  factory City.fromMap(Map<String, dynamic> data) {
    return City(
      id: data['id'],
      name: data['name'],
      imageUrl: data['image_url'],
      isPopular: data['is_popular'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'is_popular': isPopular,
    };
  }
}
