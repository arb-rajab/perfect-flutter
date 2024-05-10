import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/item_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

class TermLinkedToLabelData extends ItemData {
  TermsLinkedToLabel termLinkedToLabel;
  TermLinkedToLabelData(this.termLinkedToLabel, {super.deletedAt});

  static TermLinkedToLabelData fromJson(Map<String, dynamic> json) {
    TermLinkedToLabelData termData =
        TermLinkedToLabelData(TermsLinkedToLabel.fromJson(json));
    termData.deletedAt =
        const DeletedAtJsonConverter().fromJson(json['deleted_at']);
    return termData;
  }

  @override
  Map toJson() => {...termLinkedToLabel.toJson(), ...super.toJson()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermLinkedToLabelData &&
          other.termLinkedToLabel == termLinkedToLabel);

  @override
  int get hashCode => Object.hash(termLinkedToLabel, deletedAt);
}
