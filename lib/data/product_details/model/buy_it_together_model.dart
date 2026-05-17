import 'package:fork_up/domain/product_details/entity/buy_it_together_entity.dart';
class BuyItTogetherModel extends BuyItTogetherEntity {
  const BuyItTogetherModel({
    required super.id,
    required super.title,
    required super.discount,
    required super.productIds,
    required super.productDiscounts,
  });

  factory BuyItTogetherModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final data = json['data'];

    return BuyItTogetherModel(
      id: data['id'],

      title: data['title'] ?? '',

      discount:
      data['woodmart_main_products_discount']
          ?.toString() ??
          '',

      productIds:
      _parseIntList(
        data['woodmart_fbt_product_id'],
      ),

      productDiscounts:
      _parseStringList(
        data['woodmart_fbt_product_discount'],
      ),
    );
  }

  static List<int> _parseIntList(String? value) {
    if (value == null || value.isEmpty) {
      return [];
    }

    final cleaned = value
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '');

    return cleaned
        .split(',')
        .where((e) => e.trim().isNotEmpty)
        .map((e) => int.tryParse(e.trim()) ?? 0)
        .toList();
  }

  static List<String> _parseStringList(
      String? value,
      ) {
    if (value == null || value.isEmpty) {
      return [];
    }

    final cleaned = value
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '');

    return cleaned
        .split(',')
        .where((e) => e.trim().isNotEmpty)
        .toList();
  }
}