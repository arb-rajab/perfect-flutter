import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/coupon_linked_to_term_service.dart';
import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:drift/drift.dart' show Value;
import 'package:get/instance_manager.dart';

/// Content the user has unlocked, next to locked copies of it: every locked
/// item contains the same words as an unlocked one, so a search that leaks
/// locked content finds it.
class AssistantFixtures {
  static const int activeCouponId = 1;
  static const int expiredCouponId = 2;

  /// Folder linked to [activeCouponId].
  static const int unlockedFolderId = 1;

  /// Questions term under [unlockedFolderId].
  static const int unlockedQuestionsTermId = 2;

  /// Paid term no coupon covers.
  static const int noCouponTermId = 3;

  /// Under [expiredFolderId], linked to [expiredCouponId].
  static const int expiredTermId = 4;
  static const int expiredFolderId = 20;

  /// Free but disabled.
  static const int disabledTermId = 5;

  /// Free and enabled, under the disabled [disabledFolderId].
  static const int disabledAncestorTermId = 6;
  static const int disabledFolderId = 7;

  static const int flashcardsTermId = 8;
  static const int ebookTermId = 9;

  /// Free questions term whose questions are not downloaded.
  static const int notDownloadedTermId = 11;

  static const int unlockedQuestionId = 1;
  static const int unlockedQuestionWithoutUuidId = 6;
  static const String unlockedQuestionUuid = '00000000-0000-4000-8000-000000000001';
  static const String expiredQuestionUuid =
      '00000000-0000-4000-8000-000000000003';
  static const String disabledQuestionUuid =
      '00000000-0000-4000-8000-000000000004';
  static const Set<int> lockedQuestionIds = {2, 3, 4, 5};

  static const int unlockedFlashcardId = 1;
  static const int lockedFlashcardId = 2;
  static const int secondUnlockedFlashcardId = 3;

  static const Set<int> lockedTermIds = {
    noCouponTermId,
    expiredTermId,
    expiredFolderId,
    disabledTermId,
    disabledAncestorTermId,
    disabledFolderId,
  };

  static Future<void> seed() async {
    final TermService termService = Get.find();
    await termService.addTerms([
      _term(unlockedFolderId, 'العلوم', type: TermType.term, free: 0),
      _term(
        unlockedQuestionsTermId,
        'الخلية',
        free: 0,
        text: '<p>مقدمة عن الخلية والعضيات</p>',
      ),
      _term(noCouponTermId, 'الميتوكوندريا المقفلة', free: 0),
      _term(expiredFolderId, 'مجلد منتهي', type: TermType.term, free: 0),
      _term(expiredTermId, 'الميتوكوندريا المنتهية', free: 0),
      _term(disabledTermId, 'الميتوكوندريا المعطلة', enabled: 0),
      _term(disabledFolderId, 'مجلد معطل', type: TermType.term, enabled: 0),
      _term(disabledAncestorTermId, 'الميتوكوندريا تحت مجلد معطل'),
      _term(
        flashcardsTermId,
        'Cell biology flashcards',
        type: TermType.flashcards,
      ),
      _term(ebookTermId, 'كتاب الخلية', type: TermType.ebook),
      _term(notDownloadedTermId, 'الميتوكوندريا بدون محتوى'),
    ]);

    final TermsParentService termsParentService = Get.find();
    await termsParentService.addTermsParents([
      _parent(unlockedQuestionsTermId, unlockedFolderId),
      _parent(expiredTermId, expiredFolderId),
      _parent(disabledAncestorTermId, disabledFolderId),
    ]);

    final CouponService couponService = Get.find();
    // CURRENT_TIMESTAMP, which the expiry check compares with, is in UTC.
    final yesterday = DateTime.now()
        .toUtc()
        .subtract(const Duration(days: 1))
        .toIso8601String()
        .substring(0, 19)
        .replaceFirst('T', ' ');
    await couponService.addCoupon(
      Coupon(
        id: activeCouponId,
        serial: 'active',
        type: 1,
        free: 0,
        creation: yesterday,
        activationDate: yesterday,
        expirationDays: 365,
      ),
    );
    await couponService.addCoupon(
      const Coupon(
        id: expiredCouponId,
        serial: 'expired',
        type: 1,
        free: 0,
        creation: '2020-01-01 00:00:00',
        activationDate: '2020-01-01 00:00:00',
        expirationDays: 30,
      ),
    );
    final CouponLinkedToTermService couponLinkedToTermService = Get.find();
    await couponLinkedToTermService.addCouponLinkedToTerm(
      const CouponsLinkedToTerm(
        couponId: activeCouponId,
        termId: unlockedFolderId,
      ),
    );
    await couponLinkedToTermService.addCouponLinkedToTerm(
      const CouponsLinkedToTerm(
        couponId: expiredCouponId,
        termId: expiredFolderId,
      ),
    );

    final QuestionService questionService = Get.find();
    await questionService.addQuestions([
      question(
        unlockedQuestionId,
        unlockedQuestionUuid,
        'ما هي وظيفة <b>الميتوكوندريا</b>؟',
        unlockedQuestionsTermId,
      ),
      question(2, '00000000-0000-4000-8000-000000000002', 'ما هي وظيفة الميتوكوندريا؟', noCouponTermId),
      question(3, '00000000-0000-4000-8000-000000000003', 'ما هي وظيفة الميتوكوندريا؟', expiredTermId),
      question(4, '00000000-0000-4000-8000-000000000004', 'ما هي وظيفة الميتوكوندريا؟', disabledTermId),
      question(
        5,
        '00000000-0000-4000-8000-000000000005',
        'ما هي وظيفة الميتوكوندريا؟',
        disabledAncestorTermId,
      ),
      question(
        unlockedQuestionWithoutUuidId,
        '',
        'سؤال بدون معرف',
        unlockedQuestionsTermId,
      ),
    ]);

    final AnswerService answerService = Get.find();
    await answerService.addAnswers([
      _answer(1, unlockedQuestionId, 'إنتاج الطاقة', correct: true),
      _answer(2, unlockedQuestionId, 'تخزين الماء', correct: false),
      for (final questionId in lockedQuestionIds)
        _answer(
          10 + questionId,
          questionId,
          'إنتاج الطاقة السرية',
          correct: true,
        ),
    ]);

    final FlashcardService flashcardService = Get.find();
    await flashcardService.addFlashcards(const [
      Flashcard(
        id: unlockedFlashcardId,
        head: 'Mitochondria',
        tail: 'The <b>powerhouse</b> of the cell',
        parentTermId: flashcardsTermId,
      ),
      Flashcard(
        id: lockedFlashcardId,
        head: 'Mitochondria',
        tail: 'Locked powerhouse',
        parentTermId: noCouponTermId,
      ),
      Flashcard(
        id: secondUnlockedFlashcardId,
        head: 'Ribosome',
        tail: 'Protein synthesis',
        parentTermId: flashcardsTermId,
      ),
    ]);

    final DatabaseService databaseService = Get.find();
    await databaseService
        .into(databaseService.ebooks)
        .insert(
          const Ebook(
            encryptionKey: 'key',
            parentTermId: ebookTermId,
            creation: '2024-01-01 00:00:00',
          ),
        );
  }

  static Future<void> expireActiveCoupon() async {
    final DatabaseService databaseService = Get.find();
    await (databaseService.update(
      databaseService.coupons,
    )..where((tbl) => tbl.id.equals(activeCouponId))).write(
      const CouponsCompanion(activationDate: Value('2020-01-01 00:00:00')),
    );
  }

  static TermData _term(
    int id,
    String name, {
    int type = TermType.questions,
    int free = 1,
    int enabled = 1,
    String text = '',
  }) => TermData(
    Term(
      id: id,
      uuid: 'term-$id',
      name: name,
      type: type,
      creation: '2024-01-01 00:00:00',
      enabled: enabled,
      free: free,
      ordering: 0,
      needsUpdate: 0,
      captureable: 1,
      textCulumn: text,
      outerNote: '',
    ),
    deletedAt: const DeletedAt(null),
    visible: const Visible(1),
  );

  static TermsParentData _parent(int termId, int parentTermId) =>
      TermsParentData(
        TermsParent(
          termId: termId,
          parentTermId: parentTermId,
          rootTermId: -1,
          creation: '2024-01-01 00:00:00',
        ),
        deletedAt: const DeletedAt(null),
      );

  static Question question(
    int id,
    String uuid,
    String title,
    int parentTermId,
  ) => Question(
    id: id,
    uuid: uuid,
    title: title,
    titleTranslation: '',
    labelId: 1,
    note: '',
    noteTranslation: '',
    parentTermId: parentTermId,
    specialCharacter: 0,
    type: 1,
    edited: 0,
    imageUrl: '',
    creation: '2024-01-01 00:00:00',
    editionDate: '',
  );

  static Answer _answer(
    int id,
    int questionId,
    String title, {
    required bool correct,
  }) => Answer(
    id: id,
    uuid: 'a-$id',
    title: title,
    titleTranslation: '',
    isCorrect: correct ? 1 : 0,
    parentQuestionId: questionId,
    specialCharacter: 0,
    creation: '2024-01-01 00:00:00',
    checkedCount: 0,
  );
}
