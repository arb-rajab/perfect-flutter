import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';

@freezed
abstract class Data with _$Data {
  const factory Data([
    String? value,
  ]) = _Data;
}

class DataJsonConverter extends JsonConverter<Data, String> {
  const DataJsonConverter();
  @override
  Data fromJson(String json) => Data(json);

  @override
  String toJson(Data object) => jsonEncode(object.value);
}
