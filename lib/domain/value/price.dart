import 'package:freezed_annotation/freezed_annotation.dart';

part 'price.freezed.dart';

@freezed
abstract class Price with _$Price {
  @Assert("(value!=null&&value>=0)||value == null")
  const factory Price(int? value) = _Price;
}

class PriceJsonConverter extends JsonConverter<Price, int?> {
  const PriceJsonConverter();
  @override
  Price fromJson(int? json) => Price(json);

  @override
  int? toJson(Price object) => object.value;
}
