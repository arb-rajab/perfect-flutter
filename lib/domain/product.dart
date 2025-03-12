// ignore_for_file: invalid_annotation_target

import 'package:beta/common/date_time_converter.dart';
import 'package:beta/domain/value/description.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/price.dart';
import 'package:beta/domain/value/title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product(
      {@IdJsonConverter() required Id id,
      @TitleJsonConverter() required Title name,
      @JsonKey(name: 'image_url') required String imageUrl,
      @PriceJsonConverter() required Price price,
      @DescriptionJsonConverter() Description? description,
      @JsonKey(name: 'created_at')
      @DateTimeConverter()
      DateTime? createdAt}) = _Product;

  factory Product.fromJson(dynamic json) =>
      _$ProductFromJson(json);
}
