import 'package:beta/constants/string_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit.freezed.dart';

@freezed
abstract class Unit with _$Unit {
  const Unit._(); // Add private constructor for custom methods

  const factory Unit(
    int value,
  ) = _Unit;

  String get name {
    switch (value) {
      case 1:
        return StringConstant.usd.tr();
      case 2:
        return StringConstant.syp.tr();
      default:
        return '';
    }
  }
}

class UnitJsonConverter extends JsonConverter<Unit, int> {
  const UnitJsonConverter();
  @override
  Unit fromJson(int json) => Unit(json);

  @override
  int toJson(Unit object) => object.value;
}
