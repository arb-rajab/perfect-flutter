import 'package:freezed_annotation/freezed_annotation.dart';

part 'other_gift.freezed.dart';

@freezed
class OtherGift with _$OtherGift {
  const factory OtherGift([
    String? value,
  ]) = _OtherGift;
}

class OtherGiftJsonConverter extends JsonConverter<OtherGift, String?> {
  const OtherGiftJsonConverter();
  @override
  OtherGift fromJson(String? json) => OtherGift(json);

  @override
  String? toJson(OtherGift object) => object.value!;
}
