import 'package:beta/common/search_text_normalizer.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

void main() {
  group('normalize', () {
    test('removes tashkeel, superscript alef and tatweel', () {
      expect(SearchTextNormalizer.normalize('الْخَلِيَّةُ'), 'الخليه');
      expect(SearchTextNormalizer.normalize('رحمٰن'), 'رحمن');
      expect(SearchTextNormalizer.normalize('العـــلوم'), 'العلوم');
    });

    test('folds hamza forms, alef maqsura and taa marbuta', () {
      expect(SearchTextNormalizer.normalize('أإآٱ'), 'اااا');
      expect(SearchTextNormalizer.normalize('مستشفى'), 'مستشفي');
      expect(SearchTextNormalizer.normalize('مسؤول شاطئ'), 'مسوول شاطي');
      expect(SearchTextNormalizer.normalize('مدرسة'), 'مدرسه');
    });

    test('removes Quranic annotation marks', () {
      expect(SearchTextNormalizer.normalize('العلمۖ'), 'العلم');
    });

    test('lower-cases and collapses whitespace', () {
      expect(
        SearchTextNormalizer.normalize('  Cell\n  BIOLOGY '),
        'cell biology',
      );
    });
  });

  group('stripHtml', () {
    test('removes inline tags in place and turns block tags into spaces', () {
      expect(SearchTextNormalizer.stripHtml('ما <b>هذا</b>؟'), 'ما هذا؟');
      expect(SearchTextNormalizer.stripHtml('<p>one</p><p>two</p>'), 'one two');
      expect(SearchTextNormalizer.stripHtml('a<br/>b'), 'a b');
    });

    test('decodes common entities', () {
      expect(
        SearchTextNormalizer.stripHtml('a&nbsp;&amp;&nbsp;b &lt;3'),
        'a & b <3',
      );
    });
  });

  group('tokenize', () {
    test('splits on spaces and punctuation, including Arabic punctuation', () {
      expect(SearchTextNormalizer.tokenize('cell, biology؟ ما؛ هذا'), [
        'cell',
        'biology',
        'ما',
        'هذا',
      ]);
    });

    test('drops single letters unless the query is one letter', () {
      expect(SearchTextNormalizer.tokenize('و خليه'), ['خليه']);
      expect(SearchTextNormalizer.tokenize('x'), ['x']);
    });

    test('strips leading articles from long enough words', () {
      expect(SearchTextNormalizer.tokenize('الخليه والعلوم بالماء'), [
        'خليه',
        'علوم',
        'ماء',
      ]);
      // Too short to strip.
      expect(SearchTextNormalizer.tokenize('الا'), ['الا']);
    });

    test('removes duplicates', () {
      expect(SearchTextNormalizer.tokenize('خليه الخليه'), ['خليه']);
    });
  });

  test('escapeLike escapes the LIKE wildcards and the escape character', () {
    expect(SearchTextNormalizer.escapeLike(r'50%_a\b'), r'50\%\_a\\b');
  });

  test('sql folds text the same way as normalize', () {
    final database = sqlite3.openInMemory();
    addTearDown(database.close);
    const samples = [
      'الْخَلِيَّةُ',
      'أإآٱ مستشفى',
      'مسؤول شاطئ مدرسة',
      'العـــلوم رحمٰن',
      'Cell BIOLOGY',
    ];
    for (final sample in samples) {
      final rows = database.select(
        'select ${SearchTextNormalizer.sql('?')} as normalized',
        [sample],
      );
      expect(
        rows.single['normalized'],
        SearchTextNormalizer.normalize(sample),
        reason: sample,
      );
    }
  });
}
