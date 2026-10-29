/// Normalizes text so that searches ignore Arabic diacritics, letter variants
/// and Latin letter case.
///
/// [normalize] (Dart) and [sql] (SQLite) apply the same folding so that a
/// query normalized in Dart can be matched with LIKE against a column
/// normalized in SQL.
class SearchTextNormalizer {
  SearchTextNormalizer._();

  /// Characters removed from text: tashkeel (fathatan .. sukun), superscript
  /// alef and tatweel.
  static const List<int> _removedCodeUnits = [
    0x064B, 0x064C, 0x064D, 0x064E, 0x064F, 0x0650, 0x0651, 0x0652, //
    0x0670, 0x0640,
  ];

  /// Letter variants folded into a single letter.
  static const Map<int, int> _foldedCodeUnits = {
    0x0623: 0x0627, // أ -> ا
    0x0625: 0x0627, // إ -> ا
    0x0622: 0x0627, // آ -> ا
    0x0671: 0x0627, // ٱ -> ا
    0x0649: 0x064A, // ى -> ي
    0x0626: 0x064A, // ئ -> ي
    0x0624: 0x0648, // ؤ -> و
    0x0629: 0x0647, // ة -> ه
  };

  /// Rarer marks (Quranic annotations, extended harakat) that are stripped in
  /// Dart only, since every extra SQL replace() is paid for on every row.
  static final RegExp _extraMarks = RegExp('[ؐ-ؚٓ-ٟۖ-ۭ]');

  /// Tags that separate words; other tags (e.g. <b>) are removed in place.
  static final RegExp _blockTag = RegExp(
    r'<\s*(br|hr|/?p|/?div|/?li|/?ul|/?ol|/?tr|/?td|/?th|/?h[1-6])\b[^>]*>',
    caseSensitive: false,
  );
  static final RegExp _html = RegExp(r'<[^>]*>');
  static final RegExp _htmlEntity = RegExp(r'&(nbsp|amp|lt|gt|quot|#39);');
  static final RegExp _whitespace = RegExp(r'\s+');
  static final RegExp _tokenSeparators = RegExp(
    '[\\s\\p{P}\\p{S}،؛؟]+',
    unicode: true,
  );

  /// Leading definite articles stripped from query tokens so that a query for
  /// "الخلية" also finds "خلية".
  static const List<String> _articlePrefixes = [
    'وال',
    'بال',
    'كال',
    'فال',
    'ال',
  ];

  static String normalize(String text) {
    final buffer = StringBuffer();
    for (final codeUnit in text.replaceAll(_extraMarks, '').codeUnits) {
      if (_removedCodeUnits.contains(codeUnit)) continue;
      buffer.writeCharCode(_foldedCodeUnits[codeUnit] ?? codeUnit);
    }
    return buffer.toString().toLowerCase().replaceAll(_whitespace, ' ').trim();
  }

  /// Removes HTML tags and the common entities, keeping the visible text.
  static String stripHtml(String text) => text
      .replaceAll(_blockTag, ' ')
      .replaceAll(_html, '')
      .replaceAllMapped(_htmlEntity, (match) {
        switch (match.group(1)) {
          case 'amp':
            return '&';
          case 'lt':
            return '<';
          case 'gt':
            return '>';
          case 'quot':
            return '"';
          case '#39':
            return "'";
          default:
            return ' ';
        }
      })
      .replaceAll(_whitespace, ' ')
      .trim();

  /// Splits an already normalized query into the tokens that must all match.
  ///
  /// Single letters are dropped (they match nearly everything) unless the
  /// query is a single letter, and leading Arabic articles are removed.
  static List<String> tokenize(String normalizedQuery) {
    final words = normalizedQuery
        .split(_tokenSeparators)
        .where((word) => word.isNotEmpty)
        .toList();
    final tokens = <String>{};
    for (final word in words) {
      if (word.length < 2 && words.length > 1) continue;
      tokens.add(_stripArticle(word));
    }
    return tokens.toList();
  }

  static String _stripArticle(String word) {
    for (final prefix in _articlePrefixes) {
      if (word.startsWith(prefix) && word.length - prefix.length >= 2) {
        return word.substring(prefix.length);
      }
    }
    return word;
  }

  /// Wraps the SQL expression [expression] so that SQLite applies the same
  /// folding as [normalize] (except for the rare marks in [_extraMarks]).
  static String sql(String expression) {
    String result = "lower(coalesce($expression, ''))";
    for (final codeUnit in _removedCodeUnits) {
      result = "replace($result, char($codeUnit), '')";
    }
    _foldedCodeUnits.forEach((from, to) {
      result = 'replace($result, char($from), char($to))';
    });
    return result;
  }

  /// Escapes LIKE wildcards in [value] for use with `ESCAPE '\'`.
  static String escapeLike(String value) => value
      .replaceAll(r'\', r'\\')
      .replaceAll('%', r'\%')
      .replaceAll('_', r'\_');
}
