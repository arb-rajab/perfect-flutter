import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';

import 'value/path.dart';

class TermData {
  Path? path;
  NumberOfSubTerms? numberOfSubTerms;
  Term term;
  TermData(this.term, {this.path, this.numberOfSubTerms});

  static TermData fromJson(Map<String, dynamic> json) {
    if (json['enabled'] == null) json['enabled'] = 1;
    if (json['needsUpdate'] == null) json['needsUpdate'] = 0;
    TermData termData = TermData(Term.fromJson(json));
    termData.path = const PathJsonConverter().fromJson(json['path']);
    termData.numberOfSubTerms = const NumberOfSubTermsJsonConverter()
        .fromJson(json['numberOfSubTerms']);
    return termData;
  }

  Map toJson() {
    return {
      ...term.toJson(),
      'path': const PathJsonConverter().toJson(path!),
      'numberOfSubTerms':
          const NumberOfSubTermsJsonConverter().toJson(numberOfSubTerms!)
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TermData && other.term == term);

  @override
  int get hashCode => Object.hash(term, numberOfSubTerms, path);
}

class TermType {
  static const int term = 0;
}
