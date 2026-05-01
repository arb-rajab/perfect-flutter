import 'package:freezed_annotation/freezed_annotation.dart';

part 'description.freezed.dart';

@freezed
abstract class Description with _$Description {
  const factory Description([
    String? value,
  ]) = _Description;
}

class DescriptionJsonConverter extends JsonConverter<Description, String> {
  const DescriptionJsonConverter();
  @override
  Description fromJson(String json) => Description(json);

  @override
  String toJson(Description object) => object.value ?? '';
}
