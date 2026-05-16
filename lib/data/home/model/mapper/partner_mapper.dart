import 'package:fork_up/data/home/model/partner_model.dart';
import 'package:fork_up/domain/home/entity/partner_entity.dart';

extension PartnerMapper on Partner {
  PartnerEntity toEntity() {
    return PartnerEntity(id: id, image: image);
  }
}
