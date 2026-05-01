import 'package:beta/domain/name.dart';
import 'package:beta/domain/value/id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device.freezed.dart';
part 'device.g.dart';

@freezed
abstract class Device with _$Device {
  factory Device({
    @IdJsonConverter() required Id id,
    @NameJsonConverter() required Name name,
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  // static Map<String, dynamic> toJson(Device instance) =>
  //     _$DeviceToJson(instance);
}

class DeviceJsonConverter extends JsonConverter {
  const DeviceJsonConverter();
  @override
  fromJson(json) => _$DeviceFromJson(json);

  @override
  toJson(object) => _$DeviceToJson(object);
}
