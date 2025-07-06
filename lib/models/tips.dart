class Tips {
  final int id;
  final String title;
  final String imageUrl;
  final String updateAt;

  Tips({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.updateAt,
  });

  factory Tips.fromMap(Map<String, dynamic> data) {
    return Tips(
      id: data['id'],
      title: data['title'],
      imageUrl: data['image_url'],
      updateAt: data['update_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'update_at': updateAt,
    };
  }
}
