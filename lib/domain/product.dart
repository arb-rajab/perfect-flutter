// ignore_for_file: invalid_annotation_target

import 'package:beta/common/date_time_converter.dart';
import 'package:beta/domain/value/description.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/price.dart';
import 'package:beta/domain/value/title.dart';
import 'package:beta/domain/value/unit.dart';
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
      @JsonKey(name: 'offer_price')
      @PriceJsonConverter()
      required Price offerPrice,
      @UnitJsonConverter() required Unit unit,
      @JsonKey(name: 'description_rtl')
      @DescriptionJsonConverter()
      Description? descriptionRtl,
      @JsonKey(name: 'description_ltr')
      @DescriptionJsonConverter()
      Description? descriptionLtr,
      @JsonKey(name: 'created_at')
      @DateTimeConverter()
      DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<String>? images}) = _Product;

  factory Product.fromJson(dynamic json) => _$ProductFromJson(json).copyWith(
      images: (json['images'] as List?)
          ?.map((image) => image['image_url'] as String)
          .toList());

}
