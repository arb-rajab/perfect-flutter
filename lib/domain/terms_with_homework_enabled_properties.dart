import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/item_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

class TermsWithHomeworkEnabledProperties extends ItemData {
  TermsWithHomeworkEnabledData termsWithHomeworkEnabled;
  TermsWithHomeworkEnabledProperties(this.termsWithHomeworkEnabled,
      {super.deletedAt});

  static TermsWithHomeworkEnabledProperties fromJson(
      Map<String, dynamic> json) {
    TermsWithHomeworkEnabledProperties data = TermsWithHomeworkEnabledProperties(
        TermsWithHomeworkEnabledData.fromJson(json));
    data.deletedAt = const DeletedAtJsonConverter().fromJson(json['deleted_at']);
    return data;
  }

  @override
  Map toJson() => {...termsWithHomeworkEnabled.toJson(), ...super.toJson()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermsWithHomeworkEnabledProperties &&
          other.termsWithHomeworkEnabled == termsWithHomeworkEnabled);

  @override
  int get hashCode => Object.hash(termsWithHomeworkEnabled, deletedAt);
}
