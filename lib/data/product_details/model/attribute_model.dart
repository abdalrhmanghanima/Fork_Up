import 'package:fork_up/data/product_details/model/variation_model.dart';
import 'package:fork_up/domain/product_details/entity/attribute_entity.dart';

class AttributeModel extends AttributeEntity {
  const AttributeModel({required super.name, required super.options});

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      name: json['name'],
      options: (json['options'] as List)
          .map((e) => AttributeOptionModel.fromJson(e))
          .toList(),
    );
  }
}

class AttributeOptionModel extends AttributeOptionEntity {
  const AttributeOptionModel({required super.value, required super.variation});

  factory AttributeOptionModel.fromJson(Map<String, dynamic> json) {
    return AttributeOptionModel(
      value: json['value'],
      variation: VariationModel.fromJson(json['variation']),
    );
  }
}
