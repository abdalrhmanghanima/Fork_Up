class OfferEntity {
  final int id;
  final String url;
  final String type;
  final String? slug;
  final int? categoryId;
  final String? categoryName;

  OfferEntity({
    required this.id,
    required this.url,
    required this.type,
    this.slug,
    this.categoryId,
    this.categoryName,
  });
}
