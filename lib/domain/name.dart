import 'package:beta/domain/value/title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'name.freezed.dart';
part 'name.g.dart';

@freezed
abstract class Name with _$Name {
  factory Name({
    @TitleJsonConverter() required Title name,
  }) = _Name;

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  // static Map<String, dynamic> toJson(Name instance) => _$NameToJson(instance);
}

class NameJsonConverter extends JsonConverter {
  const NameJsonConverter();
  @override
  fromJson(json) => _$NameFromJson(json);

  @override
  toJson(object) => _$NameToJson(object);
}
