import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_of_objects.freezed.dart';

@freezed
class NumberOfObjects with _$NumberOfObjects {
  @Assert("value>=1")
  const factory NumberOfObjects(int value) = _NumberOfObjects;
}

class NumberOfObjectsJsonConverter extends JsonConverter<NumberOfObjects, int> {
  const NumberOfObjectsJsonConverter();
  @override
  NumberOfObjects fromJson(int json) => NumberOfObjects(json);

  @override
  int toJson(NumberOfObjects object) => object.value ?? 0;
}
