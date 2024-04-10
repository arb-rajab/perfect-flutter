// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_type.freezed.dart';

@freezed
class GiftType with _$GiftType {
  @Assert("value>=0&&value<=2")
  const factory GiftType(
    int value,
  ) = _GiftType;

  static const int COUPON = 0;
  static const int OTHER = 1;
  static const int NULL = 2;
}

class GiftTypeJsonConverter extends JsonConverter<GiftType, int> {
  const GiftTypeJsonConverter();
  @override
  GiftType fromJson(int json) => GiftType(json);

  @override
  int toJson(GiftType object) => object.value;
}
