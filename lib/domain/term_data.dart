import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/item_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';

import 'value/path.dart';

class TermData extends ItemData {
  Path? path;
  NumberOfSubTerms? numberOfSubTerms;
  NumberOfSubTerms? numberOfQuestions;
  NumberOfSubTerms? numberOfFlashcards;
  NumberOfSubTerms? numberOfRelatedTerms;
  Term term;
  Visible? visible;
  Id? tagId;
  Id? labelId;

  TermData(this.term,
      {this.path,
      this.numberOfSubTerms,
      super.deletedAt,
      this.visible,
      this.tagId,
      this.labelId,
      this.numberOfQuestions,
      this.numberOfFlashcards,
      this.numberOfRelatedTerms});

  bool isVisible() {
    if (visible == null) return false;
    return visible!.value == 1;
  }

  static TermData fromJson(Map<String, dynamic> json) {
    if (json['enabled'] == null) json['enabled'] = 1;
    if (json['needsUpdate'] == null) json['needsUpdate'] = 0;
    TermData termData = TermData(Term.fromJson(json));
    termData.path = const PathJsonConverter().fromJson(json['path']);
    termData.numberOfSubTerms = const NumberOfSubTermsJsonConverter()
        .fromJson(json['numberOfSubTerms']);
    termData.deletedAt =
        const DeletedAtJsonConverter().fromJson(json['deleted_at']);
    termData.visible = const VisibleJsonConverter().fromJson(json['visible']);
    termData.tagId = const IdJsonConverter().fromJson(json['tagId']);
    termData.labelId = const IdJsonConverter().fromJson(json['labelId']);
    termData.numberOfQuestions = const NumberOfSubTermsJsonConverter()
        .fromJson(json['numberOfQuestions']);
    termData.numberOfFlashcards = const NumberOfSubTermsJsonConverter()
        .fromJson(json['numberOfFlashcards']);
    termData.numberOfRelatedTerms = const NumberOfSubTermsJsonConverter()
        .fromJson(json['numberOfRelatedTerms']);
    return termData;
  }

  @override
  Map toJson() {
    return {
      ...term.toJson(),
      ...super.toJson(),
      'path': const PathJsonConverter().toJson(path),
      'numberOfSubTerms':
          const NumberOfSubTermsJsonConverter().toJson(numberOfSubTerms!),
      'visible': const VisibleJsonConverter().toJson(visible),
      'tagId': const IdJsonConverter().toJson(tagId!),
      'labelId': const IdJsonConverter().toJson(labelId!),
      'numberOfQuestions':
          const NumberOfSubTermsJsonConverter().toJson(numberOfQuestions!),
      'numberOfFlashcards':
          const NumberOfSubTermsJsonConverter().toJson(numberOfFlashcards!),
      'numberOfRelatedTerms':
          const NumberOfSubTermsJsonConverter().toJson(numberOfRelatedTerms!)
    };
  }

  static TermData fromMap(QueryRow row) {
    DatabaseService databaseService = Get.find();
    return TermData(databaseService.terms.map(row.data),
        tagId: Id(row.read<int?>('tagId')),
        labelId: Id(row.read<int?>('labelId')),
        numberOfSubTerms: NumberOfSubTerms(row.read<int>('numberOfSubTerms')),
        numberOfQuestions: NumberOfSubTerms(row.read<int>('numberOfQuestions')),
        numberOfFlashcards:
            NumberOfSubTerms(row.read<int>('numberOfFlashcards')),
        numberOfRelatedTerms:
            NumberOfSubTerms(row.read<int>('numberOfRelatedTerms')));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TermData && other.term == term);

  @override
  int get hashCode => Object.hash(
      term,
      numberOfSubTerms,
      path,
      deletedAt,
      visible,
      tagId,
      labelId,
      numberOfQuestions,
      numberOfFlashcards,
      numberOfRelatedTerms);
}

class TermType {
  static const int term = 0;
  static const int questions = 1;
  static const int ebook = 2;
  static const int template = 3;
  static const int youtubeVideos = 4;
  static const int flashcards = 5;
  static const int voiceNotes = 6;
  
  static const int maxTermType = 6;

  static bool downloadable(TermData termData) => [
        questions,
        template,
        flashcards].contains(termData.term.type) ||
      ([ebook, voiceNotes].contains(termData.term.type) && !kIsWeb);

  static bool hasFile(TermData termData) =>
      [ebook, voiceNotes].contains(termData.term.type);

  static bool hasContent(TermData termData) =>
      [questions, template, flashcards].contains(termData.term.type);
}
