import 'package:freezed_annotation/freezed_annotation.dart';

part 'layer.freezed.dart';

@freezed
abstract class Layer with _$Layer {
  @Assert("value>=0")
  const factory Layer(int value) = _Layer;
}

class LayerJsonConverter extends JsonConverter<Layer, int> {
  const LayerJsonConverter();
  @override
  Layer fromJson(int json) => Layer(json);

  @override
  int toJson(Layer object) => object.value;
}
