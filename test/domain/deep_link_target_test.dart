import 'package:beta/domain/deep_link_target.dart';
import 'package:test/test.dart';

void main() {
  DeepLinkTarget? parse(String link) => DeepLinkTarget.parse(Uri.parse(link));

  group('parse', () {
    test('reads perfect://<type>/<id> for every content type', () {
      for (final type in AssistantContentType.values) {
        expect(
          parse('perfect://${type.pathName}/12'),
          DeepLinkTarget(type, 12),
          reason: type.pathName,
        );
      }
    });

    test('reads the forms without a host and with an upper-case type', () {
      expect(
        parse('perfect:///question/3'),
        const DeepLinkTarget(AssistantContentType.question, 3),
      );
      expect(
        parse('PERFECT://Term/4'),
        const DeepLinkTarget(AssistantContentType.term, 4),
      );
      expect(
        parse('perfect://flashcard/5/'),
        const DeepLinkTarget(AssistantContentType.flashcard, 5),
      );
    });

    test('reads the app-host forms the native apps already register', () {
      expect(
        parse('prfct://perfect-app.scienceontheweb.net/flashcard/5'),
        const DeepLinkTarget(AssistantContentType.flashcard, 5),
      );
      expect(
        parse('https://perfect-app.scienceontheweb.net/faq/2'),
        const DeepLinkTarget(AssistantContentType.faq, 2),
      );
      expect(
        parse('https://perfect-app.com/ebook/9?utm=x'),
        const DeepLinkTarget(AssistantContentType.ebook, 9),
      );
    });

    test('ignores links that are not content deep links', () {
      for (final link in [
        // The existing question share links keep their own route.
        'https://perfect-app.com/q/8c1d-uuid',
        'prfct://perfect-app.scienceontheweb.net/products/3',
        'https://example.com/term/1',
        'mailto:term@example.com',
        'perfect://unknown/1',
        'perfect://term',
        'perfect://term/',
        'perfect://term/abc',
        'perfect://term/0',
        'perfect://term/-1',
        'perfect://term/1.5',
        'perfect://term/012',
        'perfect://term/1/extra',
        'perfect://news/99999999999999999999999',
      ]) {
        expect(parse(link), isNull, reason: link);
      }
    });
  });

  test('toUri round-trips through parse', () {
    for (final type in AssistantContentType.values) {
      final target = DeepLinkTarget(type, 42);
      expect(target.toUri().toString(), 'perfect://${type.pathName}/42');
      expect(DeepLinkTarget.parse(target.toUri()), target);
    }
  });
}
