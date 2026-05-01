import 'package:freezed_annotation/freezed_annotation.dart';

part 'title.freezed.dart';

@freezed
abstract class Title with _$Title {
  const factory Title([
    String? value,
  ]) = _Title;
}

class TitleJsonConverter extends JsonConverter<Title, String> {
  const TitleJsonConverter();
  @override
  Title fromJson(String json) => Title(json);

  @override
  String toJson(Title object) => object.value ?? '';
}
