import 'package:freezed_annotation/freezed_annotation.dart';

part 'text.freezed.dart';

@freezed
class Text with _$Text {
  const factory Text([
    String? value,
  ]) = _Text;
}

class TextJsonConverter extends JsonConverter<Text, String> {
  const TextJsonConverter();
  @override
  Text fromJson(String json) => Text(json);

  @override
  String toJson(Text object) => object.value ?? '';
}
