class Partner {
  final int id;
  final String image;

  Partner({
    required this.id,
    required this.image,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      image: json['image'],
    );
  }
}