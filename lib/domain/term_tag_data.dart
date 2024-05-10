import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/item_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

class TermTagData extends ItemData {
  TermTag termTag;
  TermTagData(this.termTag, {super.deletedAt});

  static TermTagData fromJson(Map<String, dynamic> json) {
    TermTagData termData = TermTagData(TermTag.fromJson(json));
    termData.deletedAt =
        const DeletedAtJsonConverter().fromJson(json['deleted_at']);
    return termData;
  }

  @override
  Map toJson() => {...termTag.toJson(), ...super.toJson()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermTagData && other.termTag == termTag);

  @override
  int get hashCode => Object.hash(termTag, deletedAt);
}
