class Variant {
  final int id;
  final String name;
  final String option;
  final double priceBeforeDiscount;
  final double priceAfterDiscount;
  final List<String> images;
  final bool inWishlist;

  Variant({
    required this.id,
    required this.name,
    required this.option,
    required this.priceBeforeDiscount,
    required this.priceAfterDiscount,
    required this.images,
    required this.inWishlist,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      name: json['name'],
      option: json['option'],
      priceBeforeDiscount: (json['price_before_discount']).toDouble(),
      priceAfterDiscount: (json['price_after_discount']).toDouble(),
      images: List<String>.from(json['images']),
      inWishlist: json['in_wishlist'],
    );
  }
}
