import 'package:beta/domain/deep_link_target.dart';

class AssistantSearchResult {
  final AssistantContentType type;
  final int id;
  final String title;

  /// A short plain-text answer or excerpt for the result.
  final String snippet;
  final Uri deepLink;

  /// Higher is more relevant. Only meaningful within one search.
  final double score;

  AssistantSearchResult({
    required this.type,
    required this.id,
    required this.title,
    required this.snippet,
    required this.score,
  }) : deepLink = DeepLinkTarget(type, id).toUri();

  Map<String, dynamic> toJson() => {
    'type': type.pathName,
    'id': id,
    'title': title,
    'snippet': snippet,
    'deepLink': deepLink.toString(),
  };

  @override
  String toString() => 'AssistantSearchResult(${type.pathName}/$id, $title)';
}
