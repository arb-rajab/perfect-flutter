/// Content types that the assistant can search and deep link to.
enum AssistantContentType {
  term('term'),
  question('question'),
  flashcard('flashcard'),
  ebook('ebook'),
  faq('faq'),
  news('news');

  /// Name used in deep links, e.g. `perfect://question/12`.
  final String pathName;

  const AssistantContentType(this.pathName);

  static AssistantContentType? fromPathName(String name) {
    for (final type in values) {
      if (type.pathName == name) return type;
    }
    return null;
  }
}

/// A deep link to one piece of content, e.g. `perfect://term/12`.
///
/// Besides the `perfect://<type>/<id>` form, [parse] accepts the forms the
/// native apps already register: `prfct://<app host>/<type>/<id>` and
/// `https://<app host>/<type>/<id>`.
class DeepLinkTarget {
  static const String scheme = 'perfect';
  static const Set<String> legacySchemes = {'prfct', 'https', 'http'};
  static const Set<String> appHosts = {
    'perfect-app.scienceontheweb.net',
    'perfect-app.com',
  };

  final AssistantContentType type;
  final int id;

  const DeepLinkTarget(this.type, this.id);

  Uri toUri() => Uri(scheme: scheme, host: type.pathName, path: '/$id');

  /// Returns null when [uri] is not a content deep link (for example the
  /// existing `/q/<uuid>` question share links), so callers can fall back to
  /// their previous handling.
  static DeepLinkTarget? parse(Uri uri) {
    final List<String> segments;
    final scheme = uri.scheme.toLowerCase();
    if (scheme == DeepLinkTarget.scheme) {
      // perfect://term/12 has host "term"; perfect:///term/12 has none.
      segments = [if (uri.host.isNotEmpty) uri.host, ...uri.pathSegments];
    } else if (legacySchemes.contains(scheme) &&
        appHosts.contains(uri.host.toLowerCase())) {
      segments = uri.pathSegments;
    } else {
      return null;
    }
    final nonEmpty = segments.where((s) => s.isNotEmpty).toList();
    if (nonEmpty.length != 2) return null;
    final type = AssistantContentType.fromPathName(nonEmpty[0].toLowerCase());
    if (type == null) return null;
    final id = int.tryParse(nonEmpty[1]);
    if (id == null || id <= 0 || nonEmpty[1] != id.toString()) return null;
    return DeepLinkTarget(type, id);
  }

  @override
  bool operator ==(Object other) =>
      other is DeepLinkTarget && other.type == type && other.id == id;

  @override
  int get hashCode => Object.hash(type, id);

  @override
  String toString() => toUri().toString();
}
