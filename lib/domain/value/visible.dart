import 'package:freezed_annotation/freezed_annotation.dart';

part 'visible.freezed.dart';

@freezed
class Visible with _$Visible {
  @Assert("value==0||value==1")
  const factory Visible(int value) = _Visible;
}

class VisibleJsonConverter extends JsonConverter<Visible?, int> {
  const VisibleJsonConverter();
  @override
  Visible fromJson(int json) => Visible(json);

  @override
  int toJson(Visible? object) => object != null ? object.value : 0;
}
