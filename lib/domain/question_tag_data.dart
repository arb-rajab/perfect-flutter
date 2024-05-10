import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/item_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';

class QuestionTagData extends ItemData {
  QuestionTag questionTag;
  NumberOfSubTerms? numberOfOccurrences;
  NumberOfSubTerms? numberOfChildTags;
  QuestionTagData(this.questionTag,
      {super.deletedAt, this.numberOfChildTags, this.numberOfOccurrences});

  static QuestionTagData fromJson(Map<String, dynamic> json) {
    QuestionTagData questionTagData =
        QuestionTagData(QuestionTag.fromJson(json));
    questionTagData.deletedAt =
        const DeletedAtJsonConverter().fromJson(json['deleted_at']);
    questionTagData.numberOfChildTags = const NumberOfSubTermsJsonConverter()
        .fromJson(json['numberOfChildTags']);
    questionTagData.numberOfOccurrences = const NumberOfSubTermsJsonConverter()
        .fromJson(json['numberOfOccurrences']);
    return questionTagData;
  }

  @override
  Map toJson() => {
        ...super.toJson(),
        ...questionTag.toJson(),
        'numberOfChildTags':
            const NumberOfSubTermsJsonConverter().toJson(numberOfChildTags!),
        'numberOfOccurrences':
            const NumberOfSubTermsJsonConverter().toJson(numberOfOccurrences!)
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionTagData && other.questionTag == questionTag);

  @override
  int get hashCode => Object.hash(
      questionTag, deletedAt, numberOfChildTags, numberOfOccurrences);
}
