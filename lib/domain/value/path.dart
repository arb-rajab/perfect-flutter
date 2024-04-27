import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'path.freezed.dart';

@freezed
class Path with _$Path {
  const factory Path([
    String? value,
  ]) = _Path;
}

class PathJsonConverter extends JsonConverter<Path, String?> {
  const PathJsonConverter();
  @override
  Path fromJson(String? json) => Path(json);

  @override
  String? toJson(Path object) => jsonEncode(object.value);
}
