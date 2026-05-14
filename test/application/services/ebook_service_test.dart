import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/ebook_service.dart';
import 'package:beta/domain/ebook_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() {
  late EbookService ebookService;
  setUp(() async {
    await initTests();
    ebookService = Get.find();
  });

  EbookData createTestEbookData({
    int parentTermId = 1,
    String encryptionKey = 'key',
    String creation = '2023-01-01T00:00:00Z',
  }) {
    final ebook = Ebook(
      encryptionKey: encryptionKey,
      parentTermId: parentTermId,
      creation: creation,
    );
    return EbookData(ebook);
  }

  TermData createTestTermData({
    int id = 1,
    String uuid = 'uuid-1',
    String name = 'Test Term',
    int type = 2,
    String creation = '2023-01-01T00:00:00Z',
    int enabled = 1,
    int free = 0,
    int ordering = 0,
    int needsUpdate = 0,
    int captureable = 1,
    String textCulumn = 'text',
    String outerNote = '',
  }) {
    final term = Term(
      id: id,
      uuid: uuid,
      name: name,
      type: type,
      creation: creation,
      enabled: enabled,
      free: free,
      ordering: ordering,
      needsUpdate: needsUpdate,
      captureable: captureable,
      textCulumn: textCulumn,
      outerNote: outerNote,
    );
    return TermData(term);
  }

  test('addEbook inserts ebook with conflict resolution', () async {
    final ebookData = createTestEbookData(parentTermId: 1);

    await ebookService.addEbook(ebookData);

    final storedEbooks =
        await databaseService.select(databaseService.ebooks).get();
    expect(storedEbooks.length, 1);
    expect(storedEbooks.first.parentTermId, 1);
    expect(storedEbooks.first.encryptionKey, 'key');
  });

  test('addEbook updates existing ebook on conflict', () async {
    final initialEbook =
        createTestEbookData(parentTermId: 1, encryptionKey: 'key1');
    await databaseService
        .into(databaseService.ebooks)
        .insert(initialEbook.ebook);

    final updatedEbook =
        createTestEbookData(parentTermId: 1, encryptionKey: 'key2');
    await ebookService.addEbook(updatedEbook);

    final storedEbooks =
        await databaseService.select(databaseService.ebooks).get();
    expect(storedEbooks.length, 1);
    expect(storedEbooks.first.encryptionKey, 'key2');
  });

  test('getEbook returns the correct ebook for a term', () async {
    final termData = createTestTermData(id: 2);
    final ebookData = createTestEbookData(parentTermId: 2);

    await ebookService.addEbook(ebookData);

    final ebook = await ebookService.getEbook(termData);
    expect(ebook.parentTermId, 2);
    expect(ebook.encryptionKey, 'key');
  });
}
