import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/item_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

class TermLinkedToTagData extends ItemData {
  TermsLinkedToTag termLinkedToTag;
  TermLinkedToTagData(this.termLinkedToTag, {super.deletedAt});

  static TermLinkedToTagData fromJson(Map<String, dynamic> json) {
    TermLinkedToTagData termData =
        TermLinkedToTagData(TermsLinkedToTag.fromJson(json));
    termData.deletedAt =
        const DeletedAtJsonConverter().fromJson(json['deleted_at']);
    return termData;
  }

  @override
  Map toJson() => {...termLinkedToTag.toJson(), ...super.toJson()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermLinkedToTagData &&
          other.termLinkedToTag == termLinkedToTag);

  @override
  int get hashCode => Object.hash(termLinkedToTag, deletedAt);
}
