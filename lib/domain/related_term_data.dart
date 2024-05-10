import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/item_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

class RelatedTermData extends ItemData {
  RelatedTerm relatedTerm;
  RelatedTermData(this.relatedTerm, {super.deletedAt});

  static RelatedTermData fromJson(Map<String, dynamic> json) {
    RelatedTermData termData = RelatedTermData(RelatedTerm.fromJson(json));
    termData.deletedAt =
        const DeletedAtJsonConverter().fromJson(json['deleted_at']);
    return termData;
  }

  @override
  Map toJson() => {...super.toJson(), ...relatedTerm.toJson()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelatedTermData && other.relatedTerm == relatedTerm);

  @override
  int get hashCode => Object.hash(relatedTerm, deletedAt);
}
