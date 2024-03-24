import 'package:freezed_annotation/freezed_annotation.dart';

class BooleanConverter implements JsonConverter<bool, int> {
  const BooleanConverter();

  @override
  bool fromJson(int json) => json == 1;

  @override
  int toJson(bool value) => value ? 1 : 0;
}
