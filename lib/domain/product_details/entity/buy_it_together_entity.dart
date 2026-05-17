class BuyItTogetherEntity {
  final int id;
  final String title;
  final String discount;
  final List<int> productIds;
  final List<String> productDiscounts;

  const BuyItTogetherEntity({
    required this.id,
    required this.title,
    required this.discount,
    required this.productIds,
    required this.productDiscounts,
  });
}