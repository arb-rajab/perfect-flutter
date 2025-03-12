// ignore_for_file: invalid_annotation_target

import 'package:beta/domain/value/product_type_id.dart';
import 'package:beta/domain/product.dart';
import 'package:beta/domain/value/title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_type.freezed.dart';
part 'product_type.g.dart';

@freezed
class ProductType with _$ProductType {
  factory ProductType({
    @ProductTypeIdJsonConverter() required ProductTypeId id,
    @JsonKey(name: 'parent_type_id')
    @ProductTypeIdJsonConverter()
    required ProductTypeId parentTypeId,
    @TitleJsonConverter() required Title name,
    @JsonKey(name: 'sub_types') @Default([]) List<ProductType> subtypes,
    @Default([]) List<Product> products,
  }) = _ProductType;

  factory ProductType.fromJson(dynamic json) =>
      _$ProductTypeFromJson(json);
}

class ProductTypeListJsonConverter
    implements JsonConverter<List<ProductType>, List<dynamic>> {
  const ProductTypeListJsonConverter();

  @override
  List<ProductType> fromJson(List<dynamic> json) {
    return json
        .map((e) => ProductType.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic> toJson(List<ProductType> object) {
    return object.map((e) => e.toJson()).toList();
  }
}
