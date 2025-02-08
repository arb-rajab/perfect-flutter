import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin.freezed.dart';
part 'admin.g.dart';

@freezed
@JsonSerializable()
class Admin with _$Admin {
  factory Admin(
      {@IdJsonConverter() required Id id,
      @TitleJsonConverter() required Title username}) = _Admin;

  static Admin fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  // static Map<String, dynamic> toJson(Admin instance) => _$AdminToJson(instance);
}

class AdminJsonConverter extends JsonConverter {
  const AdminJsonConverter();

  @override
  fromJson(json) => _$AdminFromJson(json);

  @override
  toJson(object) => _$AdminToJson(object);
}
