class Offer {
  final int id;
  final String url;
  final String type;
  final String? slug;
  final int? categoryId;
  final String? categoryName;

  Offer({
    required this.id,
    required this.url,
    required this.type,
    this.slug,
    this.categoryId,
    this.categoryName,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      url: json['url'],
      type: json['type'],
      slug: json['slug'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
    );
  }
}