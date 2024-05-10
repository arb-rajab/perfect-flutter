import 'package:freezed_annotation/freezed_annotation.dart';

part 'deleted_at.freezed.dart';

@freezed
class DeletedAt with _$DeletedAt {
  const factory DeletedAt([String? value]) = _DeletedAt;
}

class DeletedAtJsonConverter extends JsonConverter<DeletedAt, String?> {
  const DeletedAtJsonConverter();
  @override
  DeletedAt fromJson(String? json) => DeletedAt(json);

  @override
  String? toJson(DeletedAt object) => object.value ?? '';
}
