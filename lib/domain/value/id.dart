import 'package:freezed_annotation/freezed_annotation.dart';

part 'id.freezed.dart';

@freezed
class Id with _$Id {
  @Assert("value>0")
  const factory Id(int value) = _Id;
}

class IdJsonConverter extends JsonConverter<Id, int> {
  const IdJsonConverter();
  @override
  Id fromJson(int json) => Id(json);

  @override
  int toJson(Id object) => object.value ?? 0;
}
