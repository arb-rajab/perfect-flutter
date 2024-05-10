import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/item_data.dart';
import 'package:beta/domain/value/deleted_at.dart';

class TermsWithQuestionsFilteringEnabledProperties extends ItemData {
  TermsWithQuestionsFilteringEnabledData termsWithQuestionsFilteringEnabled;
  TermsWithQuestionsFilteringEnabledProperties(
      this.termsWithQuestionsFilteringEnabled,
      {super.deletedAt});

  static TermsWithQuestionsFilteringEnabledProperties fromJson(
      Map<String, dynamic> json) {
    TermsWithQuestionsFilteringEnabledProperties data =
        TermsWithQuestionsFilteringEnabledProperties(
            TermsWithQuestionsFilteringEnabledData.fromJson(json));
    data.deletedAt =
        const DeletedAtJsonConverter().fromJson(json['deleted_at']);
    return data;
  }

  @override
  Map toJson() =>
      {...termsWithQuestionsFilteringEnabled.toJson(), ...super.toJson()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermsWithQuestionsFilteringEnabledProperties &&
          other.termsWithQuestionsFilteringEnabled ==
              termsWithQuestionsFilteringEnabled);

  @override
  int get hashCode =>
      Object.hash(termsWithQuestionsFilteringEnabled, deletedAt);
}
