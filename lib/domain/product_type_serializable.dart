import 'package:beta/domain/product_serializable.dart';
import 'package:beta/domain/value/product_type_id.dart';
import 'package:beta/domain/product.dart';
import 'package:beta/domain/value/title.dart';
import 'package:json_annotation/json_annotation.dart';
import 'product_type.dart';

part 'product_type_serializable.g.dart';

@JsonSerializable()
class ProductTypeSerializable {
  @ProductTypeIdJsonConverter()
  final ProductTypeId id;

  @JsonKey(name: 'parent_type_id')
  @ProductTypeIdJsonConverter()
  final ProductTypeId parentTypeId;

  @TitleJsonConverter()
  final Title name;

  @ProductTypeListJsonConverter()
  @JsonKey(name: 'sub_types')
  final List<ProductTypeSerializable> subtypes;

  @ProductListJsonConverter()
  final List<Product> products;

  ProductTypeSerializable({
    required this.id,
    required this.parentTypeId,
    required this.name,
    this.subtypes = const [],
    this.products = const [],
  });

  factory ProductTypeSerializable.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeSerializableFromJson(json);
  Map<String, dynamic> toJson() => _$ProductTypeSerializableToJson(this);
}
