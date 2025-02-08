import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_type_id.freezed.dart';

@freezed
class ProductTypeId with _$ProductTypeId {
  @Assert("value>=0")
  const factory ProductTypeId(int value) = _ProductTypeId;
}

class ProductTypeIdJsonConverter extends JsonConverter<ProductTypeId, int> {
  const ProductTypeIdJsonConverter();
  @override
  ProductTypeId fromJson(int json) => ProductTypeId(json);

  @override
  int toJson(ProductTypeId object) => object.value;
}
