import 'package:beta/domain/deep_link_target.dart';

class AssistantSearchResult {
  final AssistantContentType type;
  final int id;
  final String title;

  /// A short plain-text answer or excerpt for the result.
  final String snippet;

  /// A longer plain-text answer (the correct answers of a question, the back
  /// of a flashcard, the answer of a FAQ, otherwise an excerpt of the body)
  /// that a device assistant can answer from.
  final String answer;

  /// The term whose access gates this result; null for public FAQs and news.
  final int? termId;
  final Uri deepLink;

  /// Higher is more relevant. Only meaningful within one search.
  final double score;

  AssistantSearchResult({
    required this.type,
    required this.id,
    required this.title,
    required this.snippet,
    required this.score,
    String? answer,
    this.termId,
  }) : answer = answer ?? snippet,
       deepLink = DeepLinkTarget(type, id).toUri();

  Map<String, dynamic> toJson() => {
    'type': type.pathName,
    'id': id,
    'title': title,
    'snippet': snippet,
    'answer': answer,
    'deepLink': deepLink.toString(),
  };

  @override
  String toString() => 'AssistantSearchResult(${type.pathName}/$id, $title)';
}
