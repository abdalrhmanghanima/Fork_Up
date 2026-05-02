class VariationEntity {
  final int id;
  final String option;
  final double priceBeforeDiscount;
  final double priceAfterDiscount;
  final int stock;

  const VariationEntity({
    required this.id,
    required this.option,
    required this.priceBeforeDiscount,
    required this.priceAfterDiscount,
    required this.stock,
  });
}