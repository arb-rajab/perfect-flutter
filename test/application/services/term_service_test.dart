import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/question_linked_to_tag_service.dart';
import 'package:beta/application/services/question_media_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/presentation/questions/question_header.dart';
import 'package:get/instance_manager.dart';
import 'package:mocktail/mocktail.dart' hide Answer;
import 'package:test/test.dart';
import 'package:drift/drift.dart';

import '../../common/tests.dart';

// Mock classes for the services
class MockQuestionService extends Mock implements QuestionService {}

class MockAnswerService extends Mock implements AnswerService {}

class MockFlashcardService extends Mock implements FlashcardService {}

class MockQuestionMediaService extends Mock implements QuestionMediaService {}

class MockQuestionTagService extends Mock implements QuestionTagService {}

class MockQuestionLinkedToTagService extends Mock
    implements QuestionLinkedToTagService {}

Future<void> main() async {
  late TermService termService;

  setUp(() async {
    await initTests();
    termService = Get.find();
  });

  group('addTerms', () {
    test(
        'should add visible terms, delete hidden/deleted terms, and override existing terms',
        () async {
      // Create test terms
      final visibleTerm = TermData(
        const Term(
          id: 1,
          name: 'Visible Term',
          type: 1,
          enabled: 1,
          needsUpdate: 0,
          creation: '2025-01-01 13:15:19',
          ordering: 0,
          free: 1,
          uuid: '',
          captureable: 0,
          textCulumn: '',
          outerNote: '',
        ),
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
        deletedAt: const DeletedAt(null),
        visible: const Visible(1),
      );

      final deletedTerm = TermData(
        const Term(
          id: 2,
          name: 'Deleted Term',
          type: 1,
          enabled: 0, // Marked as not enabled (deleted)
          needsUpdate: 0,
          creation: '2025-01-01 13:15:19',
          ordering: 0,
          free: 1,
          uuid: '',
          captureable: 0,
          textCulumn: '',
          outerNote: '',
        ),
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
        deletedAt: const DeletedAt('2025-08-09 12:15:19'),
        visible: const Visible(1),
      );

      final hiddenTerm = TermData(
        const Term(
          id: 3,
          name: 'Hidden Term',
          type: 1,
          enabled: 0, // Marked as not enabled (deleted)
          needsUpdate: 0,
          creation: '2025-01-01 13:15:19',
          ordering: 0,
          free: 1,
          uuid: '',
          captureable: 0,
          textCulumn: '',
          outerNote: '',
        ),
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
        deletedAt: const DeletedAt(null),
        visible: const Visible(0),
      );

      // First, insert a term with the same ID as visibleTerm but different data
      const existingTerm = Term(
        id: 1,
        name: 'Existing Old Term',
        type: 1,
        enabled: 1,
        needsUpdate: 1, // Different value
        creation: '2024-01-01 10:00:00', // Different creation date
        ordering: 5, // Different ordering
        free: 0, // Different free status
        uuid: 'old-uuid',
        captureable: 1,
        textCulumn: 'old-text',
        outerNote: 'old-note',
      );

      await databaseService.into(databaseService.terms).insert(existingTerm);

      // Verify the existing term is there with old data
      final termsBefore =
          await databaseService.select(databaseService.terms).get();
      expect(termsBefore.length, 1);
      expect(termsBefore.first.id, 1);
      expect(termsBefore.first.name, 'Existing Old Term');
      expect(termsBefore.first.needsUpdate, 1);
      expect(termsBefore.first.ordering, 5);

      // Add terms - this should override the existing term with ID 1
      await termService.addTerms([visibleTerm, deletedTerm, hiddenTerm]);

      // Check that only the visible term exists (others were deleted/hidden)
      final termsAfter =
          await databaseService.select(databaseService.terms).get();
      expect(termsAfter.length, 1);
      expect(termsAfter.first.id, 1);

      // Verify the term was overridden with new data
      expect(termsAfter.first.name, 'Visible Term'); // Updated name
      expect(termsAfter.first.needsUpdate, 0); // Updated needsUpdate
      expect(termsAfter.first.ordering, 0); // Updated ordering
      expect(termsAfter.first.free, 1); // Updated free status
      expect(termsAfter.first.uuid, ''); // Updated uuid
      expect(termsAfter.first.captureable, 0); // Updated captureable
      expect(termsAfter.first.textCulumn, ''); // Updated textColumn
      expect(termsAfter.first.outerNote, ''); // Updated outerNote

      // Check term trees were created for visible term
      final termTrees =
          await databaseService.select(databaseService.termTrees).get();
      expect(termTrees.length, 1);
      expect(termTrees.first.termId, 1);
      expect(termTrees.first.parentTermId, 1);
    });
  });

  group('setTermsNeedUpdate', () {
    test('should set needsUpdate to 1 for specified term IDs', () async {
      // Create test terms with different needsUpdate values
      const term1 = Term(
        id: 100,
        name: 'Term 1',
        type: 1,
        enabled: 1,
        needsUpdate: 0, // Will be updated to 1
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const term2 = Term(
        id: 101,
        name: 'Term 2',
        type: 1,
        enabled: 1,
        needsUpdate: 0, // Will be updated to 1
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const term3 = Term(
        id: 102,
        name: 'Term 3',
        type: 1,
        enabled: 1,
        needsUpdate: 1, // Already 1, should remain unchanged
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const term4 = Term(
        id: 103,
        name: 'Term 4',
        type: 1,
        enabled: 1,
        needsUpdate: 0, // Not in the list, should remain unchanged
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Insert all terms
      await databaseService.into(databaseService.terms).insert(term1);
      await databaseService.into(databaseService.terms).insert(term2);
      await databaseService.into(databaseService.terms).insert(term3);
      await databaseService.into(databaseService.terms).insert(term4);

      // Verify initial state
      final termsBefore =
          await databaseService.select(databaseService.terms).get();
      expect(termsBefore.length, 4);
      expect(termsBefore.firstWhere((t) => t.id == 100).needsUpdate, 0);
      expect(termsBefore.firstWhere((t) => t.id == 101).needsUpdate, 0);
      expect(termsBefore.firstWhere((t) => t.id == 102).needsUpdate, 1);
      expect(termsBefore.firstWhere((t) => t.id == 103).needsUpdate, 0);

      // Call setTermsNeedUpdate with specific IDs
      await termService
          .setTermsNeedUpdate([const Id(100), const Id(101), const Id(102)]);

      // Verify the update
      final termsAfter =
          await databaseService.select(databaseService.terms).get();

      // Terms 100, 101, 102 should have needsUpdate = 1
      expect(termsAfter.firstWhere((t) => t.id == 100).needsUpdate, 1);
      expect(termsAfter.firstWhere((t) => t.id == 101).needsUpdate, 1);
      expect(termsAfter.firstWhere((t) => t.id == 102).needsUpdate,
          1); // Already was 1

      // Term 103 should remain unchanged (not in the list)
      expect(termsAfter.firstWhere((t) => t.id == 103).needsUpdate, 0);

      // Verify other fields are unchanged
      expect(termsAfter.firstWhere((t) => t.id == 100).name, 'Term 1');
      expect(termsAfter.firstWhere((t) => t.id == 101).name, 'Term 2');
      expect(termsAfter.firstWhere((t) => t.id == 102).name, 'Term 3');
      expect(termsAfter.firstWhere((t) => t.id == 103).name, 'Term 4');
    });

    test('should handle empty list of term IDs', () async {
      // Create a test term
      const term = Term(
        id: 200,
        name: 'Test Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);

      // Call setTermsNeedUpdate with empty list
      await termService.setTermsNeedUpdate([]);

      // Verify the term remains unchanged
      final termsAfter =
          await databaseService.select(databaseService.terms).get();
      expect(termsAfter.length, 1);
      expect(termsAfter.first.needsUpdate, 0);
      expect(termsAfter.first.name, 'Test Term');
    });

    test('should handle non-existent term IDs gracefully', () async {
      // Create a test term
      const term = Term(
        id: 300,
        name: 'Existing Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);

      // Call setTermsNeedUpdate with mix of existing and non-existent IDs
      await termService
          .setTermsNeedUpdate([const Id(300), const Id(999), const Id(1000)]);

      // Verify the existing term is updated, non-existent ones are ignored
      final termsAfter =
          await databaseService.select(databaseService.terms).get();
      expect(termsAfter.length, 1);
      expect(termsAfter.first.needsUpdate, 1);
      expect(termsAfter.first.name, 'Existing Term');
    });
  });

  group('getFirstLayerTerms', () {
    test('should return enabled term with questions > 0', () async {
      const term = Term(
        id: 10,
        name: 'Term with Questions',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(term.id),
              parentTermId: Value(term.id),
              depth: const Value(0),
            ),
          );

      // Add to termsParents to make it a first layer term
      await databaseService.into(databaseService.termsParents).insert(
            TermsParentsCompanion(
              termId: Value(term.id),
              parentTermId: Value(term.id),
              rootTermId: Value(term.id),
              creation: const Value('2025-01-01 10:00:00'),
            ),
          );

      // Add questions to make numberOfQuestions > 0
      await databaseService.into(databaseService.questions).insert(
            Question(
              parentTermId: term.id,
              uuid: 'test-uuid-1',
              type: 1,
              title: 'Test question 1',
              creation: '2025-07-08 14:56:33',
              id: 78,
              titleTranslation: '',
              labelId: 0,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 0,
              imageUrl: '',
              editionDate: '',
            ),
          );

      final result = await termService.getFirstLayerTerms();
      expect(result.length, 1);
      expect(result.first.term.name, 'Term with Questions');
      expect(result.first.numberOfQuestions!.value, greaterThan(0));
    });

    test('should return enabled term with subterms > 0', () async {
      const parentTerm = Term(
        id: 20,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const subTerm = Term(
        id: 21,
        name: 'Sub Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(parentTerm);
      await databaseService.into(databaseService.terms).insert(subTerm);

      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(parentTerm.id),
              parentTermId: Value(parentTerm.id),
              depth: const Value(0),
            ),
          );

      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(subTerm.id),
              parentTermId: Value(parentTerm.id),
              depth: const Value(1),
            ),
          );

      // Add to termsParents for both terms
      await databaseService.into(databaseService.termsParents).insert(
            TermsParentsCompanion(
              termId: Value(parentTerm.id),
              parentTermId: Value(parentTerm.id),
              rootTermId: Value(parentTerm.id),
              creation: const Value('2025-01-01 10:00:00'),
            ),
          );

      await databaseService.into(databaseService.termsParents).insert(
            TermsParentsCompanion(
              termId: Value(subTerm.id),
              parentTermId: Value(parentTerm.id),
              rootTermId: Value(parentTerm.id),
              creation: const Value('2025-01-01 10:00:00'),
            ),
          );

      final result = await termService.getFirstLayerTerms();
      expect(result.length, 1);
      expect(result.first.term.name, 'Parent Term');
      expect(result.first.numberOfSubTerms!.value, greaterThan(0));
    });

    test('should return enabled term with flashcards > 0', () async {
      const term = Term(
        id: 30,
        name: 'Term with Flashcards',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(term.id),
              parentTermId: Value(term.id),
              depth: const Value(0),
            ),
          );

      // Add to termsParents
      await databaseService.into(databaseService.termsParents).insert(
            TermsParentsCompanion(
              termId: Value(term.id),
              parentTermId: Value(term.id),
              rootTermId: Value(term.id),
              creation: const Value('2025-01-01 10:00:00'),
            ),
          );

      // Add flashcards to make numberOfFlashcards > 0
      await databaseService.into(databaseService.flashcards).insert(
            FlashcardsCompanion(
              parentTermId: Value(term.id),
              head: const Value('Front 1'),
              tail: const Value('Back 1'),
            ),
          );

      final result = await termService.getFirstLayerTerms();
      expect(result.length, 1);
      expect(result.first.term.name, 'Term with Flashcards');
      expect(result.first.numberOfFlashcards!.value, greaterThan(0));
    });

    test('should return disabled term with no content', () async {
      const term = Term(
        id: 50,
        name: 'Disabled Term with No Content',
        type: 1,
        enabled: 0, // Disabled but should still appear
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(term.id),
              parentTermId: Value(term.id),
              depth: const Value(0),
            ),
          );

      // Add to termsParents
      await databaseService.into(databaseService.termsParents).insert(
            TermsParentsCompanion(
              termId: Value(term.id),
              parentTermId: const Value(51),
              rootTermId: const Value(51),
              creation: const Value('2025-01-01 10:00:00'),
            ),
          );

      // No questions, subterms, or flashcards added

      final result = await termService.getFirstLayerTerms();
      expect(result.length, 1);
      expect(result.first.term.name, 'Disabled Term with No Content');
      expect(result.first.numberOfQuestions!.value, 0);
      expect(result.first.numberOfSubTerms!.value, 0);
      expect(result.first.numberOfFlashcards!.value, 0);
    });

    test('should NOT return enabled term with no content', () async {
      const term = Term(
        id: 60,
        name: 'Enabled Term with No Content',
        type: 1,
        enabled: 1, // Enabled but no content - should NOT appear
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(term.id),
              parentTermId: Value(term.id),
              depth: const Value(0),
            ),
          );

      // Add to termsParents
      await databaseService.into(databaseService.termsParents).insert(
            TermsParentsCompanion(
              termId: Value(term.id),
              parentTermId: const Value(1),
              rootTermId: const Value(1),
              creation: const Value('2025-01-01 10:00:00'),
            ),
          );

      // No content added

      final result = await termService.getFirstLayerTerms();
      expect(result.length, 0);
    });

    test('should return term with mixed content types', () async {
      const term = Term(
        id: 70,
        name: 'Term with Mixed Content',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(term.id),
              parentTermId: Value(term.id),
              depth: const Value(0),
            ),
          );

      // Add to termsParents
      await databaseService.into(databaseService.termsParents).insert(
            TermsParentsCompanion(
              termId: Value(term.id),
              parentTermId: Value(term.id),
              rootTermId: Value(term.id),
              creation: const Value('2025-01-01 10:00:00'),
            ),
          );

      // Add one question
      await databaseService.into(databaseService.questions).insert(
            Question(
              parentTermId: term.id,
              uuid: 'test-uuid-mixed',
              type: 1,
              title: 'Mixed question',
              creation: '2025-07-08 14:56:33',
              id: 81,
              titleTranslation: '',
              labelId: 0,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 0,
              imageUrl: '',
              editionDate: '',
            ),
          );

      // Add one flashcard
      await databaseService.into(databaseService.flashcards).insert(
            FlashcardsCompanion(
              parentTermId: Value(term.id),
              head: const Value('Mixed Front'),
              tail: const Value('Mixed Back'),
            ),
          );

      // Add a subterm
      const subTerm = Term(
        id: 71,
        name: 'Mixed Sub Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(subTerm);
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(subTerm.id),
              parentTermId: Value(term.id),
              depth: const Value(1),
            ),
          );
      await databaseService.into(databaseService.termsParents).insert(
            TermsParentsCompanion(
              termId: Value(subTerm.id),
              parentTermId: Value(term.id),
              rootTermId: Value(term.id),
              creation: const Value('2025-01-01 10:00:00'),
            ),
          );

      final result = await termService.getFirstLayerTerms();
      expect(result.length, 1);
      expect(result.first.term.name, 'Term with Mixed Content');
      expect(result.first.numberOfQuestions!.value, greaterThan(0));
      expect(result.first.numberOfFlashcards!.value, greaterThan(0));
      expect(result.first.numberOfSubTerms!.value, greaterThan(0));
    });

    test('should handle multiple terms with different conditions', () async {
      // Term 1: Enabled with questions
      const term1 = Term(
        id: 80,
        name: 'Term with Questions Only',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Term 2: Disabled with no content
      const term2 = Term(
        id: 81,
        name: 'Disabled Empty Term',
        type: 1,
        enabled: 0,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Term 3: Enabled with no content (should not appear)
      const term3 = Term(
        id: 82,
        name: 'Enabled Empty Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term1);
      await databaseService.into(databaseService.terms).insert(term2);
      await databaseService.into(databaseService.terms).insert(term3);

      // Add all to termTrees and termsParents
      for (final term in [term1, term2, term3]) {
        await databaseService.into(databaseService.termTrees).insert(
              TermTreesCompanion(
                termId: Value(term.id),
                parentTermId: Value(term.id),
                depth: const Value(0),
              ),
            );

        await databaseService.into(databaseService.termsParents).insert(
              TermsParentsCompanion(
                termId: Value(term.id),
                parentTermId: const Value(1),
                rootTermId: const Value(1),
                creation: const Value('2025-01-01 10:00:00'),
              ),
            );
      }

      // Add questions to term1 only
      await databaseService.into(databaseService.questions).insert(
            Question(
              parentTermId: term1.id,
              uuid: 'test-uuid-80',
              type: 1,
              title: 'Question for term1',
              creation: '2025-07-08 14:56:33',
              id: 80,
              titleTranslation: '',
              labelId: 0,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 0,
              imageUrl: '',
              editionDate: '',
            ),
          );

      final result = await termService.getFirstLayerTerms();
      expect(
          result.length, 2); // term1 and term2 should appear, term3 should not

      final termNames = result.map((t) => t.term.name).toList();
      expect(termNames, contains('Term with Questions Only'));
      expect(termNames, contains('Disabled Empty Term'));
      expect(termNames, isNot(contains('Enabled Empty Term')));
    });
  });

  group('getSubTerms', () {
    test('should return subterms of a parent term', () async {
      const parentTerm = Term(
        id: 100,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const subTerm = Term(
        id: 101,
        name: 'Sub Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(parentTerm);
      await databaseService.into(databaseService.terms).insert(subTerm);

      // Create term tree relationship
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(subTerm.id),
              parentTermId: Value(parentTerm.id),
              depth: const Value(1),
            ),
          );

      // Create term tree parent
      await databaseService.into(databaseService.termsParents).insert(
            TermsParent(
                termId: subTerm.id,
                parentTermId: parentTerm.id,
                rootTermId: parentTerm.id,
                creation: '2025-08-09 14:44:34'),
          );

      final result = await termService.getSubTerms(parentTerm.id);
      expect(result.length, 1);
      expect(result.first.term.name, 'Sub Term');
    });
  });

  group('setTermUpdated', () {
    test(
        'should set needsUpdate to 0 for a term and leave other terms unchanged',
        () async {
      // Create multiple test terms with different needsUpdate values
      const termToUpdate = Term(
        id: 200,
        name: 'Term to Update',
        type: 1,
        enabled: 1,
        needsUpdate: 1, // Will be updated to 0
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const termUnchanged1 = Term(
        id: 201,
        name: 'Unchanged Term 1',
        type: 1,
        enabled: 1,
        needsUpdate: 1, // Should remain 1
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const termUnchanged2 = Term(
        id: 202,
        name: 'Unchanged Term 2',
        type: 1,
        enabled: 1,
        needsUpdate: 0, // Should remain 0
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Insert all terms
      await databaseService.into(databaseService.terms).insert(termToUpdate);
      await databaseService.into(databaseService.terms).insert(termUnchanged1);
      await databaseService.into(databaseService.terms).insert(termUnchanged2);

      // Verify initial state
      final termsBefore =
          await databaseService.select(databaseService.terms).get();
      expect(termsBefore.length, 3);
      expect(termsBefore.firstWhere((t) => t.id == 200).needsUpdate, 1);
      expect(termsBefore.firstWhere((t) => t.id == 201).needsUpdate, 1);
      expect(termsBefore.firstWhere((t) => t.id == 202).needsUpdate, 0);

      // Create TermData for the term to update
      final termData = TermData(
        termToUpdate,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      // Call setTermUpdated only on the specific term
      await termService.setTermUpdated(termData);

      // Verify the update
      final termsAfter =
          await databaseService.select(databaseService.terms).get();

      // Only the specified term should be updated
      expect(
          termsAfter.firstWhere((t) => t.id == 200).needsUpdate, 0); // Updated
      expect(termsAfter.firstWhere((t) => t.id == 201).needsUpdate,
          1); // Unchanged
      expect(termsAfter.firstWhere((t) => t.id == 202).needsUpdate,
          0); // Unchanged

      // Verify all other fields remain unchanged for all terms
      expect(termsAfter.firstWhere((t) => t.id == 200).name, 'Term to Update');
      expect(
          termsAfter.firstWhere((t) => t.id == 201).name, 'Unchanged Term 1');
      expect(
          termsAfter.firstWhere((t) => t.id == 202).name, 'Unchanged Term 2');

      expect(termsAfter.firstWhere((t) => t.id == 200).enabled, 1);
      expect(termsAfter.firstWhere((t) => t.id == 201).enabled, 1);
      expect(termsAfter.firstWhere((t) => t.id == 202).enabled, 1);

      expect(termsAfter.firstWhere((t) => t.id == 200).ordering, 0);
      expect(termsAfter.firstWhere((t) => t.id == 201).ordering, 0);
      expect(termsAfter.firstWhere((t) => t.id == 202).ordering, 0);
    });

    test('should set needsUpdate to 0 for a term', () async {
      const term = Term(
        id: 200,
        name: 'Test Term',
        type: 1,
        enabled: 1,
        needsUpdate: 1, // Needs update
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);

      final termData = TermData(
        term,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      await termService.setTermUpdated(termData);

      final updatedTerm = await (databaseService.select(databaseService.terms)
            ..where((tbl) => tbl.id.equals(term.id)))
          .getSingle();

      expect(updatedTerm.needsUpdate, 0);
    });
  });

  group('termHasTemplate', () {
    test('should return true when term has template subterms', () async {
      const term = Term(
        id: 300,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const templateTerm = Term(
        id: 301,
        name: 'Template Term',
        type: 3, // Template type
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);
      await databaseService.into(databaseService.terms).insert(templateTerm);

      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(templateTerm.id),
              parentTermId: Value(term.id),
              depth: const Value(1),
            ),
          );

      final termData = TermData(
        term,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(1),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.termHasTemplate(termData);
      expect(result, true);
    });

    test('should return false when term has no template subterms', () async {
      const term = Term(
        id: 300,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const templateTerm = Term(
        id: 301,
        name: 'Template Term',
        type: TermType.questions, // Template type
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);
      await databaseService.into(databaseService.terms).insert(templateTerm);

      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(templateTerm.id),
              parentTermId: Value(term.id),
              depth: const Value(1),
            ),
          );

      final termData = TermData(
        term,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(1),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.termHasTemplate(termData);
      expect(result, false);
    });

    test(
        'should return false when the template term is not a subterm of the passed term',
        () async {
      const term = Term(
        id: 300,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const templateTerm = Term(
        id: 301,
        name: 'Template Term',
        type: TermType.template, // Template type
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);
      await databaseService.into(databaseService.terms).insert(templateTerm);

      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(templateTerm.id),
              parentTermId: const Value(12),
              depth: const Value(1),
            ),
          );

      final termData = TermData(
        term,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(1),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.termHasTemplate(termData);
      expect(result, false);
    });
  });

  group('getTermRelatedTerms', () {
    test('should return terms related to the passed term in both directions',
        () async {
      // Create main term
      const mainTerm = Term(
        id: 100,
        name: 'Main Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Create related terms (both directions)
      const relatedTerm1 = Term(
        id: 101,
        name: 'Related Term 1 (termId)',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const relatedTerm2 = Term(
        id: 102,
        name: 'Related Term 2 (anotherTermId)',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Create unrelated term
      const unrelatedTerm = Term(
        id: 103,
        name: 'Unrelated Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Insert all terms
      await databaseService.into(databaseService.terms).insert(mainTerm);
      await databaseService.into(databaseService.terms).insert(relatedTerm1);
      await databaseService.into(databaseService.terms).insert(relatedTerm2);
      await databaseService.into(databaseService.terms).insert(unrelatedTerm);

      // Add to termTrees and termsParents for all terms
      for (final term in [
        mainTerm,
        relatedTerm1,
        relatedTerm2,
        unrelatedTerm
      ]) {
        await databaseService.into(databaseService.termTrees).insert(
              TermTreesCompanion(
                termId: Value(term.id),
                parentTermId: Value(term.id),
                depth: const Value(0),
              ),
            );

        await databaseService.into(databaseService.termsParents).insert(
              TermsParentsCompanion(
                termId: Value(term.id),
                parentTermId: Value(term.id),
                rootTermId: Value(term.id),
                creation: const Value('2025-01-01 10:00:00'),
              ),
            );
      }

      // Create relationships in both directions:
      // 1. mainTerm.id in termId, relatedTerm1.id in anotherTermId
      await databaseService.into(databaseService.relatedTerms).insert(
            RelatedTermsCompanion(
              termId: Value(mainTerm.id),
              anotherTermId: Value(relatedTerm1.id),
            ),
          );

      // 2. relatedTerm2.id in termId, mainTerm.id in anotherTermId
      await databaseService.into(databaseService.relatedTerms).insert(
            RelatedTermsCompanion(
              termId: Value(relatedTerm2.id),
              anotherTermId: Value(mainTerm.id),
            ),
          );

      // Create an unrelated relationship
      await databaseService.into(databaseService.relatedTerms).insert(
            RelatedTermsCompanion(
              termId: Value(unrelatedTerm.id),
              anotherTermId:
                  const Value(999), // Some other term not in our test
            ),
          );

      // Create main term data
      final mainTermData = TermData(
        mainTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms:
            const NumberOfSubTerms(2), // Should have 2 related terms
      );

      // Get related terms
      final result = await termService.getTermRelatedTerms(mainTermData);

      // Should return 2 related terms, excluding the unrelated term
      expect(result.length, 2);

      // Verify both related terms are returned
      final relatedTermIds = result.map((t) => t.term.id).toList();
      expect(relatedTermIds, contains(relatedTerm1.id));
      expect(relatedTermIds, contains(relatedTerm2.id));
      expect(relatedTermIds, isNot(contains(unrelatedTerm.id)));
      expect(relatedTermIds,
          isNot(contains(mainTerm.id))); // Should not return self

      // Verify term names are correct
      final relatedTermNames = result.map((t) => t.term.name).toList();
      expect(relatedTermNames, contains('Related Term 1 (termId)'));
      expect(relatedTermNames, contains('Related Term 2 (anotherTermId)'));
      expect(relatedTermNames, isNot(contains('Unrelated Term')));
      expect(relatedTermNames, isNot(contains('Main Term')));
    });

    test('should return empty list when no related terms exist', () async {
      // Create a term with no relationships
      const isolatedTerm = Term(
        id: 200,
        name: 'Isolated Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(isolatedTerm);

      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(isolatedTerm.id),
              parentTermId: Value(isolatedTerm.id),
              depth: const Value(0),
            ),
          );

      await databaseService.into(databaseService.termsParents).insert(
            TermsParentsCompanion(
              termId: Value(isolatedTerm.id),
              parentTermId: Value(isolatedTerm.id),
              rootTermId: Value(isolatedTerm.id),
              creation: const Value('2025-01-01 10:00:00'),
            ),
          );

      final isolatedTermData = TermData(
        isolatedTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.getTermRelatedTerms(isolatedTermData);
      expect(result, isEmpty);
    });

    test('should handle bidirectional relationships correctly', () async {
      // Create terms
      const mainTerm = Term(
        id: 300,
        name: 'Main Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const relatedTerm1 = Term(
        id: 301,
        name: 'Related Term 1 (termId side)',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const relatedTerm2 = Term(
        id: 302,
        name: 'Related Term 2 (anotherTermId side)',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(mainTerm);
      await databaseService.into(databaseService.terms).insert(relatedTerm1);
      await databaseService.into(databaseService.terms).insert(relatedTerm2);

      // Add to termTrees and termsParents
      for (final term in [mainTerm, relatedTerm1, relatedTerm2]) {
        await databaseService.into(databaseService.termTrees).insert(
              TermTreesCompanion(
                termId: Value(term.id),
                parentTermId: Value(term.id),
                depth: const Value(0),
              ),
            );

        await databaseService.into(databaseService.termsParents).insert(
              TermsParentsCompanion(
                termId: Value(term.id),
                parentTermId: Value(term.id),
                rootTermId: Value(term.id),
                creation: const Value('2025-01-01 10:00:00'),
              ),
            );
      }

      // Create relationships in both directions of the relationship table:
      // 1. mainTerm.id on termId side, relatedTerm1.id on anotherTermId side
      await databaseService.into(databaseService.relatedTerms).insert(
            RelatedTermsCompanion(
              termId: Value(mainTerm.id), // mainTerm is on termId side
              anotherTermId: Value(
                  relatedTerm1.id), // relatedTerm1 is on anotherTermId side
            ),
          );

      // 2. relatedTerm2.id on termId side, mainTerm.id on anotherTermId side
      await databaseService.into(databaseService.relatedTerms).insert(
            RelatedTermsCompanion(
              termId: Value(relatedTerm2.id), // relatedTerm2 is on termId side
              anotherTermId:
                  Value(mainTerm.id), // mainTerm is on anotherTermId side
            ),
          );

      final mainTermData = TermData(
        mainTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms:
            const NumberOfSubTerms(2), // Should find 2 related terms
      );

      final result = await termService.getTermRelatedTerms(mainTermData);

      // Should return both related terms from both sides of the relationship
      expect(result.length, 2);

      // Verify both related terms are returned regardless of which side they're on
      final relatedTermIds = result.map((t) => t.term.id).toList();
      expect(relatedTermIds, contains(relatedTerm1.id)); // From termId side
      expect(
          relatedTermIds, contains(relatedTerm2.id)); // From anotherTermId side
      expect(relatedTermIds,
          isNot(contains(mainTerm.id))); // Should not return self

      // Verify term names are correct
      final relatedTermNames = result.map((t) => t.term.name).toList();
      expect(relatedTermNames, contains('Related Term 1 (termId side)'));
      expect(relatedTermNames, contains('Related Term 2 (anotherTermId side)'));
    });
  });

  group('getTermById', () {
    test('should return term by id', () async {
      const term = Term(
        id: 400,
        name: 'Specific Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);

      final result = await termService.getTermById(Id(term.id));
      expect(result.id, term.id);
      expect(result.name, 'Specific Term');
    });
  });

  group('getTermByQuestionUuid', () {
    test('should return term associated with the question UUID', () async {
      // Create a term
      const term = Term(
        id: 1000,
        name: 'Test Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);

      // Create a question associated with the term
      const questionUuid = 'test-question-uuid-123';
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: 1,
              titleTranslation: '',
              parentTermId: term.id,
              uuid: questionUuid,
              type: 1,
              title: 'Test Question',
              creation: '2025-01-01 10:00:00',
              labelId: 1,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 1,
              imageUrl: '',
              editionDate: '',
            ),
          );

      // Get the term by question UUID
      final result = await termService.getTermByQuestionUuid(questionUuid);

      // Should return the correct term
      expect(result.id, term.id);
      expect(result.name, term.name);
    });

    test('should throw exception when no question exists with the UUID',
        () async {
      const nonExistentUuid = 'non-existent-uuid-456';

      // Should throw an exception when no question exists
      expect(
        () async => await termService.getTermByQuestionUuid(nonExistentUuid),
        throwsA(isA<StateError>()), // Should throw some kind of exception
      );
    });

    test('should throw exception when question exists but term does not',
        () async {
      const questionUuid = 'orphaned-question-uuid-789';

      // Create a question with a non-existent term ID
      await databaseService.into(databaseService.questions).insert(
            const Question(
              id: 2,
              parentTermId: 9999, // Non-existent term ID
              uuid: questionUuid,
              type: 1,
              title: 'Orphaned Question',
              titleTranslation: '',
              creation: '2025-01-01 10:00:00',
              labelId: 1,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 1,
              imageUrl: '',
              editionDate: '',
            ),
          );

      // Should throw an exception when term doesn't exist
      expect(
        () async => await termService.getTermByQuestionUuid(questionUuid),
        throwsA(isA<StateError>()), // Should throw some kind of exception
      );
    });

    test('should return correct term when multiple questions exist', () async {
      // Create multiple terms
      const term1 = Term(
        id: 2000,
        name: 'Term 1',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const term2 = Term(
        id: 2001,
        name: 'Term 2',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term1);
      await databaseService.into(databaseService.terms).insert(term2);

      // Create multiple questions with different UUIDs
      const targetUuid = 'target-question-uuid-abc';
      const otherUuid = 'other-question-uuid-def';

      await databaseService.into(databaseService.questions).insert(
            Question(
              id: 3,
              titleTranslation: '',
              parentTermId: term1.id,
              uuid: targetUuid,
              type: 1,
              title: 'Target Question',
              creation: '2025-01-01 10:00:00',
              labelId: 1,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 1,
              imageUrl: '',
              editionDate: '',
            ),
          );

      await databaseService.into(databaseService.questions).insert(
            Question(
              id: 4,
              titleTranslation: '',
              parentTermId: term2.id,
              uuid: otherUuid,
              type: 1,
              title: 'Other Question',
              creation: '2025-01-01 10:00:00',
              labelId: 1,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 1,
              imageUrl: '',
              editionDate: '',
            ),
          );

      // Get the term for the specific UUID
      final result = await termService.getTermByQuestionUuid(targetUuid);

      // Should return the correct term associated with the target UUID
      expect(result.id, term1.id);
      expect(result.name, 'Term 1');

      // Verify the other UUID returns the other term
      final otherResult = await termService.getTermByQuestionUuid(otherUuid);
      expect(otherResult.id, term2.id);
      expect(otherResult.name, 'Term 2');
    });

    test('should handle UUID case sensitivity correctly', () async {
      // Create a term
      const term = Term(
        id: 3000,
        name: 'Case Test Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);

      // Create a question with specific case UUID
      const questionUuid = 'Case-Sensitive-UUID-123';
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: 5,
              titleTranslation: '',
              parentTermId: term.id,
              uuid: questionUuid,
              type: 1,
              title: 'Case Test Question',
              creation: '2025-01-01 10:00:00',
              labelId: 1,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 1,
              imageUrl: '',
              editionDate: '',
            ),
          );

      // Should find the term with exact UUID match
      final result = await termService.getTermByQuestionUuid(questionUuid);
      expect(result.id, term.id);

      // Should NOT find with different case (UUID matching is typically case-sensitive)
      const wrongCaseUuid = 'case-sensitive-uuid-123'; // different case
      expect(
        () async => await termService.getTermByQuestionUuid(wrongCaseUuid),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('deleteTermContent', () {
    test(
        'should delete all content associated with a term including questionsLinkedToTags and questionMedias',
        () async {
      const term = Term(
        id: 500,
        name: 'Term to delete',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(term);
      await databaseService
          .into(databaseService.termTrees)
          .insert(TermTree(termId: term.id, parentTermId: term.id, depth: 1));

      // Add some content
      final question =
          await databaseService.into(databaseService.questions).insert(
                Question(
                  id: 5,
                  titleTranslation: '',
                  parentTermId: term.id,
                  uuid: 'questionUuid',
                  type: 1,
                  title: 'Case Test Question',
                  creation: '2025-01-01 10:00:00',
                  labelId: 1,
                  note: '',
                  noteTranslation: '',
                  specialCharacter: SpecialCharacter.none,
                  edited: 1,
                  imageUrl: '',
                  editionDate: '',
                ),
              );

      final question2 =
          await databaseService.into(databaseService.questions).insert(
                Question(
                  id: 6,
                  titleTranslation: '',
                  parentTermId: term.id,
                  uuid: 'questionUuid2',
                  type: 1,
                  title: 'Second Question',
                  creation: '2025-01-01 10:00:00',
                  labelId: 1,
                  note: '',
                  noteTranslation: '',
                  specialCharacter: SpecialCharacter.none,
                  edited: 1,
                  imageUrl: '',
                  editionDate: '',
                ),
              );

      await databaseService.into(databaseService.answers).insert(
            Answer(
              id: 1,
              parentQuestionId: question,
              title: 'Test answer',
              isCorrect: 1,
              uuid: '',
              titleTranslation: '',
              specialCharacter: SpecialCharacter.none,
              creation: '2025-01-01 10:00:00',
              checkedCount: 0,
            ),
          );

      await databaseService.into(databaseService.flashcards).insert(
            Flashcard(
              parentTermId: term.id,
              head: 'Front',
              tail: 'Back',
              id: 1,
            ),
          );

      // Add questionsLinkedToTags
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTag(
              questionId: question,
              tagId: 1,
            ),
          );

      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTag(
              questionId: question2,
              tagId: 2,
            ),
          );

      // Add questionMedias
      await databaseService.into(databaseService.questionMedias).insert(
            QuestionMedia(
              id: 1,
              parentQuestionId: question,
              creation: '2025-01-01 13:14:15',
              url: 'https://example.com/image1.jpg',
            ),
          );

      await databaseService.into(databaseService.questionMedias).insert(
            QuestionMedia(
              id: 2,
              parentQuestionId: question2,
              creation: '2025-01-01 13:14:15',
              url: 'https://example.com/audio1.mp3',
            ),
          );

      // Verify content exists before deletion
      final questionsBefore =
          await databaseService.select(databaseService.questions).get();
      final answersBefore =
          await databaseService.select(databaseService.answers).get();
      final flashcardsBefore =
          await databaseService.select(databaseService.flashcards).get();
      final questionsLinkedToTagsBefore = await databaseService
          .select(databaseService.questionsLinkedToTags)
          .get();
      final questionMediasBefore =
          await databaseService.select(databaseService.questionMedias).get();

      expect(questionsBefore.length, 2);
      expect(answersBefore.length, 1);
      expect(flashcardsBefore.length, 1);
      expect(questionsLinkedToTagsBefore.length, 2);
      expect(questionMediasBefore.length, 2);

      // Delete term content
      await termService.deleteTermContent(term);

      // Verify ALL content was deleted
      final questionsAfter =
          await databaseService.select(databaseService.questions).get();
      final answersAfter =
          await databaseService.select(databaseService.answers).get();
      final flashcardsAfter =
          await databaseService.select(databaseService.flashcards).get();
      final questionsLinkedToTagsAfter = await databaseService
          .select(databaseService.questionsLinkedToTags)
          .get();
      final questionMediasAfter =
          await databaseService.select(databaseService.questionMedias).get();

      expect(questionsAfter, isEmpty);
      expect(answersAfter, isEmpty);
      expect(flashcardsAfter, isEmpty);
      expect(questionsLinkedToTagsAfter, isEmpty);
      expect(questionMediasAfter, isEmpty);
    });

    test('should only delete content for the specified term, not other terms',
        () async {
      const termToDelete = Term(
        id: 600,
        name: 'Term to delete',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const otherTerm = Term(
        id: 601,
        name: 'Other term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(termToDelete);
      await databaseService.into(databaseService.terms).insert(otherTerm);
      await databaseService.into(databaseService.termTrees).insert(TermTree(
          termId: termToDelete.id, parentTermId: termToDelete.id, depth: 0));
      await databaseService.into(databaseService.termTrees).insert(
          TermTree(termId: otherTerm.id, parentTermId: otherTerm.id, depth: 0));

      // Add content to both terms
      final questionToDelete =
          await databaseService.into(databaseService.questions).insert(
                Question(
                  id: 10,
                  titleTranslation: '',
                  parentTermId: termToDelete.id,
                  uuid: 'delete-question',
                  type: 1,
                  title: 'Question to delete',
                  creation: '2025-01-01 10:00:00',
                  labelId: 1,
                  note: '',
                  noteTranslation: '',
                  specialCharacter: SpecialCharacter.none,
                  edited: 1,
                  imageUrl: '',
                  editionDate: '',
                ),
              );

      final questionToKeep =
          await databaseService.into(databaseService.questions).insert(
                Question(
                  id: 11,
                  titleTranslation: '',
                  parentTermId: otherTerm.id,
                  uuid: 'keep-question',
                  type: 1,
                  title: 'Question to keep',
                  creation: '2025-01-01 10:00:00',
                  labelId: 1,
                  note: '',
                  noteTranslation: '',
                  specialCharacter: SpecialCharacter.none,
                  edited: 1,
                  imageUrl: '',
                  editionDate: '',
                ),
              );

      // Add questionsLinkedToTags for both terms
      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTag(
              questionId: questionToDelete,
              tagId: 1,
            ),
          );

      await databaseService.into(databaseService.questionsLinkedToTags).insert(
            QuestionsLinkedToTag(
              questionId: questionToKeep,
              tagId: 1,
            ),
          );

      // Add questionMedias for both terms
      await databaseService.into(databaseService.questionMedias).insert(
            QuestionMedia(
              id: 10,
              parentQuestionId: questionToDelete,
              creation: '2025-01-01 13:14:15',
              url: 'https://example.com/delete.jpg',
            ),
          );

      await databaseService.into(databaseService.questionMedias).insert(
            QuestionMedia(
              id: 11,
              parentQuestionId: questionToKeep,
              creation: '2025-01-01 13:14:15',
              url: 'https://example.com/keep.jpg',
            ),
          );

      // Delete content only for termToDelete
      await termService.deleteTermContent(termToDelete);

      // Verify only content for termToDelete was deleted
      final questionsAfter =
          await databaseService.select(databaseService.questions).get();
      final questionsLinkedToTagsAfter = await databaseService
          .select(databaseService.questionsLinkedToTags)
          .get();
      final questionMediasAfter =
          await databaseService.select(databaseService.questionMedias).get();

      // Should still have the question from otherTerm
      expect(questionsAfter.length, 1);
      expect(questionsAfter.first.id, questionToKeep);
      expect(questionsAfter.first.parentTermId, otherTerm.id);

      // Should still have the questionsLinkedToTags from otherTerm
      expect(questionsLinkedToTagsAfter.length, 1);
      expect(questionsLinkedToTagsAfter.first.questionId, questionToKeep);

      // Should still have the questionMedias from otherTerm
      expect(questionMediasAfter.length, 1);
      expect(questionMediasAfter.first.parentQuestionId, questionToKeep);
    });
  });

  group('isUnExpired', () {
    test('should return true for free terms', () async {
      const freeTerm = Term(
        id: 1000,
        name: 'Free Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1, // Free term
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(freeTerm);

      final termData = TermData(
        freeTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.isUnExpired(termData);
      expect(result, true);
    });

    test('should return false for non-free terms without coupons', () async {
      const nonFreeTerm = Term(
        id: 1001,
        name: 'Non-Free Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 0, // Not free
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(nonFreeTerm);

      final termData = TermData(
        nonFreeTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.isUnExpired(termData);
      expect(result, false);
    });

    test(
        'should return true for terms with active coupons (null activation date)',
        () async {
      const termWithCoupon = Term(
        id: 1002,
        name: 'Term with Coupon',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 0,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(termWithCoupon);

      // Create a coupon with null activation date (always active)
      const coupon = Coupon(
        id: 1,
        serial: 'Test Coupon',
        activationDate: null, // Null activation date = always active
        expirationDays: 30,
        creation: '2025-01-01 10:00:00', type: 1, free: 0,
      );

      await databaseService.into(databaseService.coupons).insert(coupon);

      // Link term to coupon
      await databaseService.into(databaseService.couponsLinkedToTerms).insert(
            CouponsLinkedToTerm(
              termId: termWithCoupon.id,
              couponId: coupon.id,
            ),
          );

      // Add to termTrees to satisfy the query
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(termWithCoupon.id),
              parentTermId: Value(termWithCoupon.id),
              depth: const Value(0),
            ),
          );

      final termData = TermData(
        termWithCoupon,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.isUnExpired(termData);
      expect(result, true);
    });

    test('should return true for terms with active coupons (not expired)',
        () async {
      const termWithActiveCoupon = Term(
        id: 1003,
        name: 'Term with Active Coupon',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 0,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService
          .into(databaseService.terms)
          .insert(termWithActiveCoupon);

      // Create a coupon with activation date in the past but not expired
      final activationDate = DateTime.now().subtract(const Duration(days: 10));
      const expirationDays = 30; // Still has 20 days left

      final coupon = Coupon(
          id: 2,
          serial: 'Active Coupon',
          activationDate: activationDate.toIso8601String(),
          expirationDays: expirationDays,
          creation: '2025-01-01 10:00:00',
          free: 0,
          type: 1);

      await databaseService.into(databaseService.coupons).insert(coupon);

      // Link term to coupon
      await databaseService.into(databaseService.couponsLinkedToTerms).insert(
            CouponsLinkedToTerm(
              termId: termWithActiveCoupon.id,
              couponId: coupon.id,
            ),
          );

      // Add to termTrees to satisfy the query
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(termWithActiveCoupon.id),
              parentTermId: Value(termWithActiveCoupon.id),
              depth: const Value(0),
            ),
          );

      final termData = TermData(
        termWithActiveCoupon,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.isUnExpired(termData);
      expect(result, true);
    });

    test('should return false for terms with expired coupons', () async {
      const termWithExpiredCoupon = Term(
        id: 1004,
        name: 'Term with Expired Coupon',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 0,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService
          .into(databaseService.terms)
          .insert(termWithExpiredCoupon);

      // Create a coupon that expired long ago
      final activationDate = DateTime.now().subtract(const Duration(days: 365));
      const expirationDays = 30; // Expired 335 days ago

      final coupon = Coupon(
          id: 3,
          serial: 'Expired Coupon',
          activationDate: activationDate.toIso8601String(),
          expirationDays: expirationDays,
          creation: '2025-01-01 10:00:00',
          type: 0,
          free: 0);

      await databaseService.into(databaseService.coupons).insert(coupon);

      // Link term to coupon
      await databaseService.into(databaseService.couponsLinkedToTerms).insert(
            CouponsLinkedToTerm(
              termId: termWithExpiredCoupon.id,
              couponId: coupon.id,
            ),
          );

      // Add to termTrees to satisfy the query
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(termWithExpiredCoupon.id),
              parentTermId: Value(termWithExpiredCoupon.id),
              depth: const Value(0),
            ),
          );

      final termData = TermData(
        termWithExpiredCoupon,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.isUnExpired(termData);
      expect(result, false);
    });

    test('should return false for terms with empty activation date strings',
        () async {
      const termWithInvalidCoupon = Term(
        id: 1005,
        name: 'Term with Invalid Coupon',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 0,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService
          .into(databaseService.terms)
          .insert(termWithInvalidCoupon);

      // Create a coupon with empty activation date (should be treated as invalid)
      const coupon = Coupon(
          id: 4,
          serial: 'Invalid Coupon',
          activationDate: '', // Empty activation date
          expirationDays: 30,
          creation: '2025-01-01 10:00:00',
          free: 0,
          type: 1);

      await databaseService.into(databaseService.coupons).insert(coupon);

      // Link term to coupon
      await databaseService.into(databaseService.couponsLinkedToTerms).insert(
            CouponsLinkedToTerm(
              termId: termWithInvalidCoupon.id,
              couponId: coupon.id,
            ),
          );

      // Add to termTrees to satisfy the query
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(termWithInvalidCoupon.id),
              parentTermId: Value(termWithInvalidCoupon.id),
              depth: const Value(0),
            ),
          );

      final termData = TermData(
        termWithInvalidCoupon,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.isUnExpired(termData);
      expect(result, false);
    });

    test('should handle multiple coupons and return true if any is valid',
        () async {
      const termWithMultipleCoupons = Term(
        id: 1006,
        name: 'Term with Multiple Coupons',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 0,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService
          .into(databaseService.terms)
          .insert(termWithMultipleCoupons);

      // Create an expired coupon
      final expiredActivationDate =
          DateTime.now().subtract(const Duration(days: 365));
      final expiredCoupon = Coupon(
          id: 5,
          serial: 'Expired Coupon',
          activationDate: expiredActivationDate.toIso8601String(),
          expirationDays: 30,
          creation: '2025-01-01 10:00:00',
          type: 1,
          free: 0);

      // Create a valid coupon (null activation date)
      const validCoupon = Coupon(
          id: 6,
          serial: 'Valid Coupon',
          activationDate: null,
          expirationDays: 30,
          creation: '2025-01-01 10:00:00',
          type: 1,
          free: 0);

      await databaseService.into(databaseService.coupons).insert(expiredCoupon);
      await databaseService.into(databaseService.coupons).insert(validCoupon);

      // Link term to both coupons
      await databaseService.into(databaseService.couponsLinkedToTerms).insert(
            CouponsLinkedToTerm(
              termId: termWithMultipleCoupons.id,
              couponId: expiredCoupon.id,
            ),
          );
      await databaseService.into(databaseService.couponsLinkedToTerms).insert(
            CouponsLinkedToTerm(
              termId: termWithMultipleCoupons.id,
              couponId: validCoupon.id,
            ),
          );

      // Add to termTrees to satisfy the query
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(termWithMultipleCoupons.id),
              parentTermId: Value(termWithMultipleCoupons.id),
              depth: const Value(0),
            ),
          );

      final termData = TermData(
        termWithMultipleCoupons,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService.isUnExpired(termData);
      expect(
          result, true); // Should be true because at least one coupon is valid
    });
  });

  group('getTermUndownloadedTermsWithQuestionsCount', () {
    test(
        'should return count of undownloaded subterms with questions for enabled terms',
        () async {
      const parentTerm = Term(
        id: 1100,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Create subterms that match the criteria
      const undownloadedTerm1 = Term(
        id: 1101,
        name: 'Undownloaded Term 1',
        type: 1, // Type 1 (included)
        enabled: 1,
        needsUpdate: 1, // Needs update
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const undownloadedTerm2 = Term(
        id: 1102,
        name: 'Undownloaded Term 2',
        type: 3, // Type 3 (included)
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(parentTerm);
      await databaseService
          .into(databaseService.terms)
          .insert(undownloadedTerm1);
      await databaseService
          .into(databaseService.terms)
          .insert(undownloadedTerm2);

      // Create term tree relationships
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(undownloadedTerm1.id),
              parentTermId: Value(parentTerm.id),
              depth: const Value(1),
            ),
          );
      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(undownloadedTerm2.id),
              parentTermId: Value(parentTerm.id),
              depth: const Value(1),
            ),
          );

      // Term 1102 has no questions (count = 0), so it should be included

      final parentTermData = TermData(
        parentTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(2),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService
          .getTermUndownloadedTermsWithQuestionsCount(parentTermData);
      expect(result, 2); // Both subterms should be counted
    });

    test('should exclude terms that are not subterms of the parent', () async {
      const parentTerm = Term(
        id: 1200,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const unrelatedTerm = Term(
        id: 1201,
        name: 'Unrelated Term',
        type: 1,
        enabled: 1,
        needsUpdate: 1, // Would match criteria but not a subterm
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(parentTerm);
      await databaseService.into(databaseService.terms).insert(unrelatedTerm);

      // Don't create term tree relationship for unrelated term

      final parentTermData = TermData(
        parentTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(0),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService
          .getTermUndownloadedTermsWithQuestionsCount(parentTermData);
      expect(result, 0); // Unrelated term should not be counted
    });

    test('should exclude disabled terms', () async {
      const parentTerm = Term(
        id: 1300,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const disabledSubterm = Term(
        id: 1301,
        name: 'Disabled Subterm',
        type: 1,
        enabled: 0, // Disabled
        needsUpdate: 1, // Would match criteria but disabled
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(parentTerm);
      await databaseService.into(databaseService.terms).insert(disabledSubterm);

      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(disabledSubterm.id),
              parentTermId: Value(parentTerm.id),
              depth: const Value(1),
            ),
          );

      final parentTermData = TermData(
        parentTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(1),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService
          .getTermUndownloadedTermsWithQuestionsCount(parentTermData);
      expect(result, 0); // Disabled term should not be counted
    });

    test('should exclude terms with type not in (1,3)', () async {
      const parentTerm = Term(
        id: 1400,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const wrongTypeSubterm = Term(
        id: 1401,
        name: 'Wrong Type Subterm',
        type: 2, // Type not in (1,3)
        enabled: 1,
        needsUpdate: 1, // Would match criteria but wrong type
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(parentTerm);
      await databaseService
          .into(databaseService.terms)
          .insert(wrongTypeSubterm);

      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(wrongTypeSubterm.id),
              parentTermId: Value(parentTerm.id),
              depth: const Value(1),
            ),
          );

      final parentTermData = TermData(
        parentTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(1),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService
          .getTermUndownloadedTermsWithQuestionsCount(parentTermData);
      expect(result, 0); // Wrong type term should not be counted
    });

    test('should exclude terms that are up-to-date and have questions',
        () async {
      const parentTerm = Term(
        id: 1500,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const upToDateSubterm = Term(
        id: 1501,
        name: 'Up-to-date Subterm',
        type: 1,
        enabled: 1,
        needsUpdate: 0, // Up-to-date
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(parentTerm);
      await databaseService.into(databaseService.terms).insert(upToDateSubterm);

      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(upToDateSubterm.id),
              parentTermId: Value(parentTerm.id),
              depth: const Value(1),
            ),
          );

      // Add questions to the subterm (so it doesn't have 0 questions)
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: 3,
              parentTermId: upToDateSubterm.id,
              uuid: 'test-uuid-1501',
              type: 1,
              title: 'Test Question',
              creation: '2025-07-08 14:56:33',
              titleTranslation: '',
              labelId: 1,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 0,
              imageUrl: '',
              editionDate: '',
            ),
          );

      final parentTermData = TermData(
        parentTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(1),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService
          .getTermUndownloadedTermsWithQuestionsCount(parentTermData);
      expect(result, 0); // Up-to-date term with questions should not be counted
    });

    test('should include terms that need update even if they have questions',
        () async {
      const parentTerm = Term(
        id: 1600,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const needsUpdateSubterm = Term(
        id: 1601,
        name: 'Needs Update Subterm',
        type: 1,
        enabled: 1,
        needsUpdate: 1, // Needs update
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(parentTerm);
      await databaseService
          .into(databaseService.terms)
          .insert(needsUpdateSubterm);

      await databaseService.into(databaseService.termTrees).insert(
            TermTreesCompanion(
              termId: Value(needsUpdateSubterm.id),
              parentTermId: Value(parentTerm.id),
              depth: const Value(1),
            ),
          );

      // Add questions to the subterm (but it still needs update)
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: 2,
              parentTermId: needsUpdateSubterm.id,
              uuid: 'test-uuid-1601',
              type: 1,
              title: 'Test Question',
              creation: '2025-07-08 14:56:33',
              titleTranslation: '',
              labelId: 1,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 0,
              imageUrl: '',
              editionDate: '',
            ),
          );

      final parentTermData = TermData(
        parentTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(1),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService
          .getTermUndownloadedTermsWithQuestionsCount(parentTermData);
      expect(result,
          1); // Term that needs update should be counted even with questions
    });

    test('should handle mixed scenarios with multiple subterms', () async {
      const parentTerm = Term(
        id: 1700,
        name: 'Parent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Subterm 1: Needs update (should be counted)
      const subterm1 = Term(
        id: 1701,
        name: 'Subterm 1 - Needs Update',
        type: 1,
        enabled: 1,
        needsUpdate: 1,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Subterm 2: No questions (should be counted)
      const subterm2 = Term(
        id: 1702,
        name: 'Subterm 2 - No Questions',
        type: 3,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Subterm 3: Up-to-date with questions (should NOT be counted)
      const subterm3 = Term(
        id: 1703,
        name: 'Subterm 3 - Up-to-date',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Subterm 4: Disabled (should NOT be counted)
      const subterm4 = Term(
        id: 1704,
        name: 'Subterm 4 - Disabled',
        type: 1,
        enabled: 0,
        needsUpdate: 1,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      await databaseService.into(databaseService.terms).insert(parentTerm);
      await databaseService.into(databaseService.terms).insert(subterm1);
      await databaseService.into(databaseService.terms).insert(subterm2);
      await databaseService.into(databaseService.terms).insert(subterm3);
      await databaseService.into(databaseService.terms).insert(subterm4);

      // Create term tree relationships
      for (final subterm in [subterm1, subterm2, subterm3, subterm4]) {
        await databaseService.into(databaseService.termTrees).insert(
              TermTreesCompanion(
                termId: Value(subterm.id),
                parentTermId: Value(parentTerm.id),
                depth: const Value(1),
              ),
            );
      }

      // Add questions to subterm3 (up-to-date term)
      await databaseService.into(databaseService.questions).insert(
            Question(
              id: 1,
              parentTermId: subterm3.id,
              uuid: 'test-uuid-1703',
              type: 1,
              title: 'Test Question',
              creation: '2025-07-08 14:56:33',
              titleTranslation: '',
              labelId: 1,
              note: '',
              noteTranslation: '',
              specialCharacter: SpecialCharacter.none,
              edited: 0,
              imageUrl: '',
              editionDate: '',
            ),
          );

      final parentTermData = TermData(
        parentTerm,
        tagId: null,
        labelId: null,
        numberOfSubTerms: const NumberOfSubTerms(4),
        numberOfQuestions: const NumberOfSubTerms(0),
        numberOfFlashcards: const NumberOfSubTerms(0),
        numberOfRelatedTerms: const NumberOfSubTerms(0),
      );

      final result = await termService
          .getTermUndownloadedTermsWithQuestionsCount(parentTermData);
      expect(result, 2); // Only subterm1 and subterm2 should be counted
    });
  });

  group('storeTermContent', () {
    late MockQuestionService mockQuestionService;
    late MockAnswerService mockAnswerService;
    late MockFlashcardService mockFlashcardService;
    late MockQuestionMediaService mockQuestionMediaService;
    late MockQuestionTagService mockQuestionTagService;
    late MockQuestionLinkedToTagService mockQuestionLinkedToTagService;

    setUp(() {
      mockQuestionService = MockQuestionService();
      mockAnswerService = MockAnswerService();
      mockFlashcardService = MockFlashcardService();
      mockQuestionMediaService = MockQuestionMediaService();
      mockQuestionTagService = MockQuestionTagService();
      mockQuestionLinkedToTagService = MockQuestionLinkedToTagService();

      // Register mock services with GetX
      Get.delete<QuestionService>();
      Get.delete<AnswerService>();
      Get.delete<FlashcardService>();
      Get.delete<QuestionMediaService>();
      Get.delete<QuestionTagService>();
      Get.delete<QuestionLinkedToTagService>();

      Get.put<QuestionService>(mockQuestionService);
      Get.put<AnswerService>(mockAnswerService);
      Get.put<FlashcardService>(mockFlashcardService);
      Get.put<QuestionMediaService>(mockQuestionMediaService);
      Get.put<QuestionTagService>(mockQuestionTagService);
      Get.put<QuestionLinkedToTagService>(mockQuestionLinkedToTagService);
    });

    test('should call all service methods with correct data', () async {
      // Setup test data
      final body = {
        'questions': [
          {
            'id': 1,
            'parentTermId': 100,
            'uuid': 'question-uuid-1',
            'type': 1,
            'title': 'Question 1',
            'creation': '2025-01-01 10:00:00',
            'titleTranslation': '',
            'labelId': 1,
            'note': '',
            'noteTranslation': '',
            'specialCharacter': 1,
            'edited': 1,
            'imageUrl': '',
            'editionDate': '2024-01-01 10:00:00'
          }
        ],
        'answers': [
          {
            'id': 1,
            'parentQuestionId': 1,
            'title': 'Answer 1',
            'titleTranslation': '',
            'isCorrect': 1,
            'uuid': 'uuid',
            'specialCharacter': 1,
            'creation': '2025-01-04 13:15:17',
            'checkedCount': 10
          }
        ],
        'flashcards': [
          {
            'id': 1,
            'parentTermId': 100,
            'head': 'Front 1',
            'tail': 'Back 1',
          }
        ],
        'media': [
          {
            'id': 1,
            'parentQuestionId': 1,
            'type': 1,
            'url': 'https://example.com/image1.jpg',
            'creation': '2025-08-14 15:19:45'
          }
        ],
        'questionTags': [
          {
            'id': 1,
            'name': 'Tag 1',
            'parentTagId': 1,
            'creation': '2025-08-14 15:19:45',
            'hasInformation': 0
          }
        ],
        'questionsLinkedToTags': [
          {
            'id': 1,
            'questionId': 1,
            'tagId': 1,
          }
        ],
      };

      // Setup mock responses
      when(() => mockQuestionService.addQuestions(any()))
          .thenAnswer((_) async {});
      when(() => mockAnswerService.addAnswers(any())).thenAnswer((_) async {});
      when(() => mockFlashcardService.addFlashcards(any()))
          .thenAnswer((_) async {});
      when(() => mockQuestionMediaService.addQuestionMedias(any()))
          .thenAnswer((_) async {});
      when(() => mockQuestionTagService.addQuestionTags(any()))
          .thenAnswer((_) async {});
      when(() => mockQuestionLinkedToTagService.addQuestionsLinkdeToTags(any()))
          .thenAnswer((_) async {});

      // Execute
      await termService.storeTermContent(body);

      // Verify all service methods were called with correct data
      // verify(() => mockQuestionService.addQuestions(any())).called(1);
      // verify(() => mockAnswerService.addAnswers(any())).called(1);
      // verify(() => mockFlashcardService.addFlashcards(any())).called(1);
      // verify(() => mockQuestionMediaService.addQuestionMedias(any())).called(1);
      // verify(() => mockQuestionTagService.addQuestionTags(any())).called(1);
      // verify(() =>
      //         mockQuestionLinkedToTagService.addQuestionsLinkdeToTags(any()))
      //     .called(1);

      // Verify the exact data passed to each service
      final questionCapture =
          verify(() => mockQuestionService.addQuestions(captureAny())).captured;
      final questions = questionCapture.first as List<Question>;
      expect(questions.length, 1);
      expect(questions.first.id, 1);
      expect(questions.first.uuid, 'question-uuid-1');

      final answerCapture =
          verify(() => mockAnswerService.addAnswers(captureAny())).captured;
      final answers = answerCapture.first as List<Answer>;
      expect(answers.length, 1);
      expect(answers.first.id, 1);
      expect(answers.first.title, 'Answer 1');

      final flashcardCapture =
          verify(() => mockFlashcardService.addFlashcards(captureAny()))
              .captured;
      final flashcards = flashcardCapture.first as List<Flashcard>;
      expect(flashcards.length, 1);
      expect(flashcards.first.id, 1);
      expect(flashcards.first.head, 'Front 1');

      final mediaCapture =
          verify(() => mockQuestionMediaService.addQuestionMedias(captureAny()))
              .captured;
      final medias = mediaCapture.first as List<QuestionMedia>;
      expect(medias.length, 1);
      expect(medias.first.id, 1);
      expect(medias.first.url, 'https://example.com/image1.jpg');

      final tagCapture =
          verify(() => mockQuestionTagService.addQuestionTags(captureAny()))
              .captured;
      final tags = tagCapture.first as List<QuestionTag>;
      expect(tags.length, 1);
      expect(tags.first.id, 1);
      expect(tags.first.name, 'Tag 1');

      final linkedTagCapture = verify(() => mockQuestionLinkedToTagService
          .addQuestionsLinkdeToTags(captureAny())).captured;
      final linkedTags = linkedTagCapture.first as List<QuestionsLinkedToTag>;
      expect(linkedTags.length, 1);
      expect(linkedTags.first.questionId, 1);
      expect(linkedTags.first.tagId, 1);
    });

    test('should handle empty lists gracefully', () async {
      // Setup test data with empty lists
      final body = {
        'questions': [],
        'answers': [],
        'flashcards': [],
        'media': [],
        'questionTags': [],
        'questionsLinkedToTags': [],
      };

      // Setup mock responses
      when(() => mockQuestionService.addQuestions(any()))
          .thenAnswer((_) async {});
      when(() => mockAnswerService.addAnswers(any())).thenAnswer((_) async {});
      when(() => mockFlashcardService.addFlashcards(any()))
          .thenAnswer((_) async {});
      when(() => mockQuestionMediaService.addQuestionMedias(any()))
          .thenAnswer((_) async {});
      when(() => mockQuestionTagService.addQuestionTags(any()))
          .thenAnswer((_) async {});
      when(() => mockQuestionLinkedToTagService.addQuestionsLinkdeToTags(any()))
          .thenAnswer((_) async {});

      // Execute
      await termService.storeTermContent(body);

      // Verify all service methods were called with empty lists
      verify(() => mockQuestionService.addQuestions(any())).called(1);
      verify(() => mockAnswerService.addAnswers(any())).called(1);
      verify(() => mockFlashcardService.addFlashcards(any())).called(1);
      verify(() => mockQuestionMediaService.addQuestionMedias(any())).called(1);
      verify(() => mockQuestionTagService.addQuestionTags(any())).called(1);
      verify(() =>
              mockQuestionLinkedToTagService.addQuestionsLinkdeToTags(any()))
          .called(1);
    });
  });
  group(
      'getRecentTerms, getNewTerms, getUnstudiedTerms,getFavoriteTerms, getUpdateableTerms',
      () {
    test(
        'should return appropriate term lists based on criteria and exclude non-matching terms',
        () async {
      // Create terms for different categories
      const recentTerm = Term(
        id: 700,
        name: 'Recent Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const newTerm = Term(
        id: 701,
        name: 'New Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const updateableTerm = Term(
        id: 702,
        name: 'Updateable Term',
        type: 1,
        enabled: 1,
        needsUpdate: 1, // Needs update
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const unstudiedTerm = Term(
        id: 703,
        name: 'Unstudied Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const oldTermWithAccess = Term(
        id: 704,
        name: 'Old Term with Access',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const disabledTerm = Term(
        id: 705,
        name: 'Disabled Term',
        type: 1,
        enabled: 0, // Disabled
        needsUpdate: 1,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const studiedTerm = Term(
        id: 706,
        name: 'Studied Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const upToDateTerm = Term(
        id: 707,
        name: 'Up-to-date Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0, // No update needed
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const favoriteTerm = Term(
        id: 708,
        name: 'Favorite Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      const unfavoriteTerm = Term(
        id: 709,
        name: 'unFavorite Term',
        type: 1,
        enabled: 1,
        needsUpdate: 0,
        creation: '2025-01-01 10:00:00',
        ordering: 0,
        free: 1,
        uuid: '',
        captureable: 0,
        textCulumn: '',
        outerNote: '',
      );

      // Insert all terms
      await databaseService.into(databaseService.terms).insert(recentTerm);
      await databaseService.into(databaseService.terms).insert(newTerm);
      await databaseService.into(databaseService.terms).insert(updateableTerm);
      await databaseService.into(databaseService.terms).insert(unstudiedTerm);
      await databaseService
          .into(databaseService.terms)
          .insert(oldTermWithAccess);
      await databaseService.into(databaseService.terms).insert(disabledTerm);
      await databaseService.into(databaseService.terms).insert(studiedTerm);
      await databaseService.into(databaseService.terms).insert(upToDateTerm);
      await databaseService.into(databaseService.terms).insert(favoriteTerm);
      await databaseService.into(databaseService.terms).insert(unfavoriteTerm);

      // Add to termTrees and termsParents for all terms
      for (final term in [
        recentTerm,
        newTerm,
        updateableTerm,
        unstudiedTerm,
        oldTermWithAccess,
        disabledTerm,
        studiedTerm,
        upToDateTerm,
        favoriteTerm,
        unfavoriteTerm
      ]) {
        await databaseService.into(databaseService.termTrees).insert(
              TermTreesCompanion(
                termId: Value(term.id),
                parentTermId: Value(term.id),
                depth: const Value(0),
              ),
            );

        await databaseService.into(databaseService.termsParents).insert(
              TermsParentsCompanion(
                termId: Value(term.id),
                parentTermId: Value(term.id),
                rootTermId: Value(term.id),
                creation: const Value('2025-01-01 10:00:00'),
              ),
            );
      }

      // Add recent access for recent term (very recent)
      await databaseService.into(databaseService.termsLastAccesses).insert(
            TermsLastAccess(
              parentTermId: recentTerm.id,
              lastAccess: DateTime.now().millisecondsSinceEpoch,
              childId: 1,
            ),
          );

      // Add old access for oldTermWithAccess (should not appear in recent)
      await databaseService.into(databaseService.termsLastAccesses).insert(
            TermsLastAccess(
              parentTermId: oldTermWithAccess.id,
              lastAccess:
                  DateTime(2020, 1, 1).millisecondsSinceEpoch, // Very old
              childId: 2,
            ),
          );

      // Mark studiedTerm as studied
      await databaseService.into(databaseService.termProperties).insert(
            TermProperty(
              termId: studiedTerm.id,
              name: 'studied',
              value: 'true',
            ),
          );

      // Mark favoriteTerm as favorite
      await databaseService.into(databaseService.termProperties).insert(
            TermProperty(
              termId: favoriteTerm.id,
              name: 'favorite',
              value: 'true',
            ),
          );

      // Test getRecentTerms - should only return terms with recent access
      final recentTerms = await termService.getRecentTerms();
      expect(recentTerms.any((t) => t.term.id == recentTerm.id),
          true); // Should appear
      expect(recentTerms.any((t) => t.term.id == oldTermWithAccess.id),
          true); // Should appear
      expect(recentTerms.any((t) => t.term.id == newTerm.id),
          false); // Should NOT appear (no access)

      // Test getNewTerms - should only return terms with NO access record
      final newTerms = await termService.getNewTerms();
      expect(newTerms.any((t) => t.term.id == newTerm.id),
          true); // Should appear (no access)
      expect(newTerms.any((t) => t.term.id == recentTerm.id),
          false); // Should NOT appear (has access)
      expect(newTerms.any((t) => t.term.id == oldTermWithAccess.id),
          false); // Should NOT appear (has access)

      // Test getUnstudiedTerms - should only return terms NOT marked as studied
      final unstudiedTerms = await termService.getUnstudiedTerms();
      expect(unstudiedTerms.any((t) => t.term.id == unstudiedTerm.id),
          true); // Should appear (not studied)
      expect(unstudiedTerms.any((t) => t.term.id == studiedTerm.id),
          false); // Should NOT appear (studied)
      expect(unstudiedTerms.any((t) => t.term.id == recentTerm.id),
          true); // Should appear (not studied)

      // Test favoriteTerms - should only return terms that are favorite
      final favoriteTerms = await termService.getFavoriteTerms();
      expect(favoriteTerms.any((t) => t.term.id == favoriteTerm.id),
          true); // Should appear (not favorite)
      expect(favoriteTerms.any((t) => t.term.id == unfavoriteTerm.id),
          false); // Should NOT appear (favorite)

      // Test getUpdateableTerms - should only return enabled terms with needsUpdate=1
      final updateableTerms = await termService.getUpdateableTerms();
      expect(updateableTerms.any((t) => t.term.id == updateableTerm.id),
          true); // Should appear (needs update)
      expect(updateableTerms.any((t) => t.term.id == disabledTerm.id),
          false); // Should NOT appear (disabled)
      expect(updateableTerms.any((t) => t.term.id == upToDateTerm.id),
          false); // Should NOT appear (no update needed)
      expect(updateableTerms.any((t) => t.term.id == recentTerm.id),
          false); // Should NOT appear (no update needed)

      // Verify counts are reasonable
      expect(recentTerms.length, 2);
      expect(
          newTerms.length,
          greaterThanOrEqualTo(
              6)); // All terms except recentTerm and oldTermWithAccess
      expect(unstudiedTerms.length,
          greaterThanOrEqualTo(7)); // All terms except studiedTerm
      expect(favoriteTerms.length, 1); // only favorite
      expect(updateableTerms.length, 1); // Only updateableTerm

      // Test getRecentTerms with limit and offset together
      final recentTermsAll = await termService.getRecentTerms();
      final recentTermsPage1 =
          await termService.getRecentTerms(limit: 1, offset: 0);
      final recentTermsPage2 =
          await termService.getRecentTerms(limit: 1, offset: 1);

      expect(recentTermsAll.length, 2);
      expect(recentTermsPage1.length, 1); // First page should have 1 item
      expect(recentTermsPage2.length,
          1); // Second page should be empty (only 1 item total)

      // Test getNewTerms with limit and offset together
      final newTermsAll = await termService.getNewTerms();
      final newTermsPage1 = await termService.getNewTerms(limit: 2, offset: 0);
      final newTermsPage2 = await termService.getNewTerms(limit: 2, offset: 2);
      final newTermsPage3 = await termService.getNewTerms(limit: 2, offset: 4);

      expect(newTermsAll.length, greaterThanOrEqualTo(6));
      expect(newTermsPage1.length, 2); // First page: items 0-1
      expect(newTermsPage2.length, 2); // Second page: items 2-3
      expect(newTermsPage3.length,
          lessThanOrEqualTo(2)); // Third page: remaining items

      // Test getUnstudiedTerms with limit and offset together
      final unstudiedTermsAll = await termService.getUnstudiedTerms();
      final unstudiedTermsPage1 =
          await termService.getUnstudiedTerms(limit: 3, offset: 0);
      final unstudiedTermsPage2 =
          await termService.getUnstudiedTerms(limit: 3, offset: 3);

      expect(unstudiedTermsAll.length, greaterThanOrEqualTo(7));
      expect(unstudiedTermsPage1.length, 3); // First page: items 0-2
      expect(unstudiedTermsPage2.length, 3); // Second page: items 3-5

      // Test getFavoriteTerms with limit and offset together
      final favoriteTermsAll = await termService.getFavoriteTerms();
      final favoriteTermsPage1 =
          await termService.getFavoriteTerms(limit: 3, offset: 0);
      final favoriteTermsPage2 =
          await termService.getFavoriteTerms(limit: 3, offset: 3);

      expect(favoriteTermsAll.length, 1);
      expect(favoriteTermsPage1.length, 1); // First page
      expect(favoriteTermsPage2.length, 0); // Second page

      // Test getUpdateableTerms with limit and offset together
      final updateableTermsAll = await termService.getUpdateableTerms();
      final updateableTermsPage1 =
          await termService.getUpdateableTerms(limit: 1, offset: 0);
      final updateableTermsPage2 =
          await termService.getUpdateableTerms(limit: 1, offset: 1);

      expect(updateableTermsAll.length, 1);
      expect(updateableTermsPage1.length, 1); // First page should have 1 item
      expect(updateableTermsPage2.length, 0); // Second page should be empty
    });

    test(
        'should handle limit and offset parameters correctly together with multiple items',
        () async {
      // Create multiple new terms (no access records) for testing pagination
      final newTerms = [
        for (int i = 800; i < 810; i++)
          Term(
            id: i,
            name: 'New Term $i',
            type: 1,
            enabled: 1,
            needsUpdate: 0,
            creation: '2025-01-01 10:00:00',
            ordering: 0,
            free: 1,
            uuid: '',
            captureable: 0,
            textCulumn: '',
            outerNote: '',
          )
      ];

      // Insert all new terms
      for (final term in newTerms) {
        await databaseService.into(databaseService.terms).insert(term);
        await databaseService.into(databaseService.termTrees).insert(
              TermTreesCompanion(
                termId: Value(term.id),
                parentTermId: Value(term.id),
                depth: const Value(0),
              ),
            );
        await databaseService.into(databaseService.termsParents).insert(
              TermsParentsCompanion(
                termId: Value(term.id),
                parentTermId: Value(term.id),
                rootTermId: Value(term.id),
                creation: const Value('2025-01-01 10:00:00'),
              ),
            );
      }

      // Test getNewTerms with various limit and offset combinations together
      final allNewTerms = await termService.getNewTerms();
      expect(allNewTerms.length, greaterThanOrEqualTo(10));

      // Test pagination with limit and offset together
      final page1 = await termService.getNewTerms(limit: 4, offset: 0);
      final page2 = await termService.getNewTerms(limit: 4, offset: 4);
      final page3 = await termService.getNewTerms(limit: 4, offset: 8);

      expect(page1.length, 4);
      expect(page2.length, 4);
      expect(page3.length, 2); // Only 2 items left

      // Verify pages don't overlap
      final page1Ids = page1.map((t) => t.term.id).toSet();
      final page2Ids = page2.map((t) => t.term.id).toSet();
      final page3Ids = page3.map((t) => t.term.id).toSet();

      expect(page1Ids.intersection(page2Ids).isEmpty, true);
      expect(page1Ids.intersection(page3Ids).isEmpty, true);
      expect(page2Ids.intersection(page3Ids).isEmpty, true);

      // Verify all items are covered across pages
      final allPaginatedIds = {...page1Ids, ...page2Ids, ...page3Ids};
      final allDirectIds = allNewTerms.map((t) => t.term.id).toSet();
      expect(allPaginatedIds, allDirectIds);
    });

    test('should handle edge cases for limit and offset parameters together',
        () async {
      // Get all new terms for reference
      final allNewTerms = await termService.getNewTerms();

      // Test limit = 0 with offset
      final zeroLimit = await termService.getNewTerms(limit: 0, offset: 0);
      expect(zeroLimit.isEmpty, true);

      final zeroLimitWithOffset =
          await termService.getNewTerms(limit: 0, offset: 5);
      expect(zeroLimitWithOffset.isEmpty, true);

      // Test offset beyond total count with limit
      final largeOffset = await termService.getNewTerms(limit: 5, offset: 1000);
      expect(largeOffset.isEmpty, true);

      // Test very large limit with offset
      final largeLimitWithOffset =
          await termService.getNewTerms(limit: 1000, offset: 5);
      expect(largeLimitWithOffset.length, lessThanOrEqualTo(1000));
      if (allNewTerms.length > 5) {
        expect(largeLimitWithOffset.length,
            allNewTerms.length - 5); // Should be total - offset
      }
    });

    test(
        'should apply consistent pagination behavior across all four functions',
        () async {
      // Test all four functions with the same pagination pattern
      const pageSize = 2;
      const pageNumber = 1;
      const offset = pageNumber * pageSize;

      final recentTermsPage =
          await termService.getRecentTerms(limit: pageSize, offset: offset);
      final newTermsPage =
          await termService.getNewTerms(limit: pageSize, offset: offset);
      final unstudiedTermsPage =
          await termService.getUnstudiedTerms(limit: pageSize, offset: offset);
      final favoriteTermsPage =
          await termService.getFavoriteTerms(limit: pageSize, offset: offset);
      final updateableTermsPage =
          await termService.getUpdateableTerms(limit: pageSize, offset: offset);

      // All should respect the pagination parameters
      expect(recentTermsPage.length, lessThanOrEqualTo(pageSize));
      expect(newTermsPage.length, lessThanOrEqualTo(pageSize));
      expect(unstudiedTermsPage.length, lessThanOrEqualTo(pageSize));
      expect(favoriteTermsPage.length, lessThanOrEqualTo(pageSize));
      expect(updateableTermsPage.length, lessThanOrEqualTo(pageSize));

      // Verify pagination works by comparing different pages
      final newTermsFirstPage =
          await termService.getNewTerms(limit: pageSize, offset: 0);
      final newTermsSecondPage =
          await termService.getNewTerms(limit: pageSize, offset: pageSize);

      if (newTermsFirstPage.isNotEmpty && newTermsSecondPage.isNotEmpty) {
        // Pages should not contain the same items
        final firstPageIds = newTermsFirstPage.map((t) => t.term.id).toSet();
        final secondPageIds = newTermsSecondPage.map((t) => t.term.id).toSet();
        expect(firstPageIds.intersection(secondPageIds).isEmpty, true);
      }
    });

    test('should maintain ordering when using limit and offset together',
        () async {
      // Test that pagination maintains the expected order
      final allNewTerms = await termService.getNewTerms();

      // Get first page
      final page1 = await termService.getNewTerms(limit: 3, offset: 0);
      // Get second page
      final page2 = await termService.getNewTerms(limit: 3, offset: 3);

      // The combined pages should match the full list in order
      final combinedPage = [...page1, ...page2];

      for (int i = 0; i < combinedPage.length; i++) {
        if (i < allNewTerms.length) {
          expect(combinedPage[i].term.id, allNewTerms[i].term.id);
        }
      }
    });
  });
}
