import 'dart:math';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/public_content_cache_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/common/search_text_normalizer.dart';
import 'package:beta/domain/assistant_search_result.dart';
import 'package:beta/domain/deep_link_target.dart';
import 'package:beta/domain/term_data.dart';
import 'package:drift/drift.dart';

/// Searches the content the user can open, for the assistant.
///
/// Gated content (terms, questions with their correct answers, flashcards and
/// ebooks) only comes from terms in [TermService.unlockedTermIdsQuery], so
/// locked or expired content is never returned. FAQs and news are public and
/// come from [PublicContentCacheService].
///
/// Matching is a normalized LIKE (see [SearchTextNormalizer]): every query
/// token must appear in the title or body. FTS5 is not used because its
/// tokenizers do not fold Arabic letter variants, and the encrypted native
/// database and the web database would both need an extra synced index.
class AssistantSearchService {
  static const int defaultLimit = 10;
  static const int snippetLength = 160;

  /// Rows fetched per content type before ranking.
  static const int _candidatesPerType = 200;

  /// Term types whose content can be opened from a deep link, with the table
  /// that holds their downloaded content.
  static const Map<int, String> _openableTermContentTables = {
    TermType.questions: 'questions',
    TermType.template: 'questions',
    TermType.flashcards: 'flashcards',
    TermType.images: 'images',
    TermType.ebook: 'ebooks',
    TermType.voiceNotes: 'voiceNotes',
    TermType.videoFile: 'videoFiles',
  };

  static const Map<AssistantContentType, double> _typeWeights = {
    AssistantContentType.term: 4,
    AssistantContentType.ebook: 4,
    AssistantContentType.faq: 3,
    AssistantContentType.question: 2,
    AssistantContentType.flashcard: 2,
    AssistantContentType.news: 1,
  };

  final DatabaseService databaseService;
  final PublicContentCacheService publicContentCacheService;

  AssistantSearchService({
    required this.databaseService,
    required this.publicContentCacheService,
  });

  /// Returns up to [limit] results for [query], most relevant first.
  Future<List<AssistantSearchResult>> search(
    String query, {
    int limit = defaultLimit,
  }) async {
    final normalizedQuery = SearchTextNormalizer.normalize(
      SearchTextNormalizer.stripHtml(query),
    );
    final tokens = SearchTextNormalizer.tokenize(normalizedQuery);
    if (tokens.isEmpty || limit <= 0) return [];

    final candidates = [
      ...await _searchTerms(tokens, normalizedQuery),
      ...await _searchQuestions(tokens, normalizedQuery),
      ...await _searchFlashcards(tokens, normalizedQuery),
      ..._searchFrequentQuestions(),
      ..._searchNews(),
    ];

    final results = <AssistantSearchResult>[];
    for (final candidate in candidates) {
      final score = _score(candidate, normalizedQuery, tokens);
      if (score == null) continue;
      results.add(
        AssistantSearchResult(
          type: candidate.type,
          id: candidate.id,
          title: candidate.title,
          snippet: _snippet(candidate, tokens),
          score: score,
        ),
      );
    }
    results.sort((a, b) {
      final byScore = b.score.compareTo(a.score);
      if (byScore != 0) return byScore;
      final byType = a.type.index.compareTo(b.type.index);
      return byType != 0 ? byType : a.id.compareTo(b.id);
    });
    return results.take(limit).toList();
  }

  Future<List<_Candidate>> _searchTerms(
    List<String> tokens,
    String normalizedQuery,
  ) async {
    final hasContent = _openableTermContentTables.entries
        .map(
          (e) =>
              '(t.type=${e.key} and exists (select 1 from ${e.value} where parentTermId=t.id))',
        )
        .join(' or ');
    final rows = await _select(
      rawQuery:
          "select t.id as id, t.type as type, coalesce(t.name, '') as title, "
          "coalesce(t.text, '') || ' ' || coalesce(t.outerNote, '') as body, "
          "'' as answer "
          "from terms t where t.id in (select id from unlockedTerms) and ($hasContent)",
      tokens: tokens,
      normalizedQuery: normalizedQuery,
    );
    return rows
        .map(
          (row) => _Candidate(
            type: row.read<int>('type') == TermType.ebook
                ? AssistantContentType.ebook
                : AssistantContentType.term,
            id: row.read<int>('id'),
            title: SearchTextNormalizer.stripHtml(row.read<String>('title')),
            body: SearchTextNormalizer.stripHtml(row.read<String>('body')),
          ),
        )
        .toList();
  }

  /// Questions match on their title, translation, note and correct answers;
  /// the correct answers are the snippet.
  Future<List<_Candidate>> _searchQuestions(
    List<String> tokens,
    String normalizedQuery,
  ) async {
    final rows = await _select(
      rawQuery:
          "select q.id as id, coalesce(q.title, '') as title, "
          "coalesce((select group_concat(a.title, char(10)) from answers a "
          "where a.parentQuestionId=q.id and a.isCorrect=1), '') as answer, "
          "coalesce(q.titleTranslation, '') || ' ' || coalesce(q.note, '') as body "
          "from questions q where q.parentTermId in (select id from unlockedTerms)",
      bodyExpression: "raw.answer || ' ' || raw.body",
      tokens: tokens,
      normalizedQuery: normalizedQuery,
    );
    return rows.map((row) {
      final answer = row
          .read<String>('answer')
          .split('\n')
          .map(SearchTextNormalizer.stripHtml)
          .where((e) => e.isNotEmpty)
          .join(' / ');
      return _Candidate(
        type: AssistantContentType.question,
        id: row.read<int>('id'),
        title: SearchTextNormalizer.stripHtml(row.read<String>('title')),
        body:
            '$answer ${SearchTextNormalizer.stripHtml(row.read<String>('body'))}',
        answer: answer,
      );
    }).toList();
  }

  Future<List<_Candidate>> _searchFlashcards(
    List<String> tokens,
    String normalizedQuery,
  ) async {
    final rows = await _select(
      rawQuery:
          "select f.id as id, coalesce(f.head, '') as title, "
          "coalesce(f.tail, '') as body, "
          "'' as answer from flashcards f "
          "where f.parentTermId in (select id from unlockedTerms)",
      tokens: tokens,
      normalizedQuery: normalizedQuery,
    );
    return rows.map((row) {
      final tail = SearchTextNormalizer.stripHtml(row.read<String>('body'));
      return _Candidate(
        type: AssistantContentType.flashcard,
        id: row.read<int>('id'),
        title: SearchTextNormalizer.stripHtml(row.read<String>('title')),
        body: tail,
        answer: tail,
      );
    }).toList();
  }

  Iterable<_Candidate> _searchFrequentQuestions() => publicContentCacheService
      .getFrequentQuestions()
      .where((e) => e.id.value != null)
      .map((e) {
        final description = SearchTextNormalizer.stripHtml(
          e.description.value ?? '',
        );
        return _Candidate(
          type: AssistantContentType.faq,
          id: e.id.value!,
          title: SearchTextNormalizer.stripHtml(e.title.value ?? ''),
          body: description,
          answer: description,
        );
      });

  Iterable<_Candidate> _searchNews() => publicContentCacheService
      .getNews()
      .where((e) => e.id.value != null)
      .map(
        (e) => _Candidate(
          type: AssistantContentType.news,
          id: e.id.value!,
          title: SearchTextNormalizer.stripHtml(e.title.value ?? ''),
          body: SearchTextNormalizer.stripHtml(e.content.value ?? ''),
        ),
      );

  /// Runs [rawQuery] (which must select `id`, `title`, `body` and `answer`,
  /// and may use the `unlockedTerms` CTE) and keeps the rows where every token
  /// is in the normalized title or [bodyExpression].
  ///
  /// The `limit -1` subqueries stop SQLite from flattening them, so each row
  /// is normalized once instead of once per token.
  Future<List<QueryRow>> _select({
    required String rawQuery,
    required List<String> tokens,
    required String normalizedQuery,
    String bodyExpression = 'raw.body',
  }) {
    const like = r"like ? escape '\'";
    final variables = <Variable>[];
    final conditions = tokens
        .map((token) {
          final pattern = '%${SearchTextNormalizer.escapeLike(token)}%';
          variables
            ..add(Variable.withString(pattern))
            ..add(Variable.withString(pattern));
          return '(searchTitle $like or searchBody $like)';
        })
        .join(' and ');
    variables.add(
      Variable.withString(
        '%${SearchTextNormalizer.escapeLike(normalizedQuery)}%',
      ),
    );
    variables.add(Variable.withInt(_candidatesPerType));
    return databaseService
        .customSelect(
          'with unlockedTerms(id) as (${TermService.unlockedTermIdsQuery}) '
          'select * from (select raw.*, '
          '${SearchTextNormalizer.sql('raw.title')} as searchTitle, '
          '${SearchTextNormalizer.sql(bodyExpression)} as searchBody '
          'from ($rawQuery limit -1) raw limit -1) '
          'where $conditions '
          'order by searchTitle $like desc, length(searchTitle) '
          'limit ?',
          variables: variables,
        )
        .get();
  }

  /// Scores [candidate], or returns null when a token is missing. SQL already
  /// filtered the rows; this re-checks on the HTML-free text.
  double? _score(
    _Candidate candidate,
    String normalizedQuery,
    List<String> tokens,
  ) {
    final title = SearchTextNormalizer.normalize(candidate.title);
    final body = SearchTextNormalizer.normalize(candidate.body);
    double score = _typeWeights[candidate.type]!;
    for (final token in tokens) {
      final index = title.indexOf(token);
      if (index >= 0) {
        score += 10;
        if (index == 0 || title[index - 1] == ' ') score += 5;
      } else if (body.contains(token)) {
        score += 3;
      } else {
        return null;
      }
    }
    if (title == normalizedQuery) {
      score += 100;
    } else if (title.startsWith(normalizedQuery)) {
      score += 60;
    } else if (title.contains(normalizedQuery)) {
      score += 40;
    } else if (body.contains(normalizedQuery)) {
      score += 15;
    }
    // Prefer concise titles among otherwise equal matches.
    return score - min(title.length, 200) / 100;
  }

  /// The answer when the content has one, otherwise an excerpt of the body
  /// around the first matching word.
  String _snippet(_Candidate candidate, List<String> tokens) {
    final answer = candidate.answer;
    final text = answer != null && answer.isNotEmpty ? answer : candidate.body;
    if (text.length <= snippetLength) return text;
    final words = text.split(' ');
    int start = words.indexWhere((word) {
      final normalized = SearchTextNormalizer.normalize(word);
      return tokens.any(normalized.contains);
    });
    start = max(0, start - 8);
    final buffer = StringBuffer(start > 0 ? '…' : '');
    for (int i = start; i < words.length; i++) {
      if (buffer.length + words[i].length > snippetLength) {
        buffer.write('…');
        break;
      }
      if (i > start) buffer.write(' ');
      buffer.write(words[i]);
    }
    return buffer.toString().trim();
  }
}

class _Candidate {
  final AssistantContentType type;
  final int id;
  final String title;
  final String body;
  final String? answer;

  _Candidate({
    required this.type,
    required this.id,
    required this.title,
    required this.body,
    this.answer,
  });
}
