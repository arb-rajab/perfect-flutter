import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin.freezed.dart';
part 'admin.g.dart';

@freezed
abstract class Admin with _$Admin {
  const factory Admin({
    @IdJsonConverter() required Id id,
    @TitleJsonConverter() required Title username,
  }) = _Admin;

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
}

class AdminJsonConverter extends JsonConverter<Admin, Map<String, dynamic>> {
  const AdminJsonConverter();

  @override
  Admin fromJson(Map<String, dynamic> json) => Admin.fromJson(json);

  @override
  Map<String, dynamic> toJson(Admin object) => object.toJson();
}
