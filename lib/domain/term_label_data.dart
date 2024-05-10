import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/item_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

class TermLabelData extends ItemData {
  TermLabel termLabel;
  TermLabelData(this.termLabel, {super.deletedAt});

  static TermLabelData fromJson(Map<String, dynamic> json) {
    TermLabelData termData = TermLabelData(TermLabel.fromJson(json));
    termData.deletedAt =
        const DeletedAtJsonConverter().fromJson(json['deleted_at']);
    return termData;
  }

  @override
  Map toJson() => {...termLabel.toJson(), ...super.toJson()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermLabelData && other.termLabel == termLabel);

  @override
  int get hashCode => Object.hash(termLabel, deletedAt);
}
