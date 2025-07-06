class Space {
  final int id;
  final String name;
  final String imageUrl;
  final int price;
  final String city;
  final String country;
  final int rating;

  Space({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.city,
    required this.country,
    required this.rating,
  });

  // Konversi dari Map (data dari Supabase) ke objek Space
  factory Space.fromMap(Map<String, dynamic> data) {
    return Space(
      id: data['id'],
      name: data['name'],
      imageUrl: data['image_url'],
      price: data['price'],
      city: data['city'],
      country: data['country'],
      rating: data['rating'],
    );
  }

  // Konversi dari objek Space ke Map (untuk insert/update ke Supabase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'price': price,
      'city': city,
      'country': country,
      'rating': rating,
    };
  }
}
