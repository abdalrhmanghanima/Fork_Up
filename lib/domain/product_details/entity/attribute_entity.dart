import 'package:fork_up/domain/product_details/entity/variation_entity.dart';

class AttributeEntity {
  final String name;
  final List<AttributeOptionEntity> options;

  const AttributeEntity({
    required this.name,
    required this.options,
  });
}

class AttributeOptionEntity {
  final String value;
  final VariationEntity variation;

  const AttributeOptionEntity({
    required this.value,
    required this.variation,
  });
}