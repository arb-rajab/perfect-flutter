import 'package:freezed_annotation/freezed_annotation.dart';

part 'root_term_id.freezed.dart';

@freezed
class RootTermId with _$RootTermId {
  const factory RootTermId(int value) = _RootTermId;
}

class RootTermIdJsonConverter extends JsonConverter<RootTermId, int> {
  const RootTermIdJsonConverter();
  @override
  RootTermId fromJson(int json) => RootTermId(json);

  @override
  int toJson(RootTermId object) => object.value;
}
