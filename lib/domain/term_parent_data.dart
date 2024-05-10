import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/item_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

class TermsParentData extends ItemData {
  TermsParent termsParent;
  TermsParentData(this.termsParent, {super.deletedAt});

  static TermsParentData fromJson(Map<String, dynamic> json) {
    TermsParentData termData = TermsParentData(TermsParent.fromJson(json));
    termData.deletedAt =
        const DeletedAtJsonConverter().fromJson(json['deleted_at']);
    return termData;
  }

  @override
  Map toJson() => {...termsParent.toJson(), ...super.toJson()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermsParentData && other.termsParent == termsParent);

  @override
  int get hashCode => Object.hash(termsParent, deletedAt);
}
