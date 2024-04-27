import 'package:freezed_annotation/freezed_annotation.dart';

part 'type.freezed.dart';

@freezed
class Type with _$Type {
  @Assert("value>0")
  const factory Type(int value) = _Type;
}

class TypeJsonConverter extends JsonConverter<Type, int> {
  const TypeJsonConverter();
  @override
  Type fromJson(int json) => Type(json);

  @override
  int toJson(Type object) => object.value;
}
