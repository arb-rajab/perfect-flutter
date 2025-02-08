import 'package:beta/common/date_time_converter.dart';
import 'package:beta/domain/value/description.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/price.dart';
import 'package:beta/domain/value/title.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_serializable.g.dart';

@JsonSerializable()
class ProductSerializable {
  @IdJsonConverter()
  final Id id;

  @TitleJsonConverter()
  final Title name;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  @PriceJsonConverter()
  final Price price;

  @DescriptionJsonConverter()
  final Description? description;

  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  final DateTime? createdAt;

  ProductSerializable(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price,
      this.description,
      this.createdAt});

  factory ProductSerializable.fromJson(Map<String, dynamic> json) =>
      _$ProductSerializableFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSerializableToJson(this);
}

class ProductListJsonConverter
    implements JsonConverter<List<ProductSerializable>, List<dynamic>> {
  const ProductListJsonConverter();

  @override
  List<ProductSerializable> fromJson(List<dynamic> json) {
    return json
        .map((e) => ProductSerializable.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic> toJson(List<ProductSerializable> object) {
    return object.map((e) => e.toJson()).toList();
  }
}
