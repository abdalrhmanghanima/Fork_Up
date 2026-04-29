class VariantEntity {
  final int id;
  final String name;
  final String option;
  final double priceBeforeDiscount;
  final double priceAfterDiscount;
  final List<String> images;
  final bool inWishlist;

  VariantEntity({
    required this.id,
    required this.name,
    required this.option,
    required this.priceBeforeDiscount,
    required this.priceAfterDiscount,
    required this.images,
    required this.inWishlist,
  });
}