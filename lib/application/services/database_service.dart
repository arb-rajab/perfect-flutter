import 'package:beta/application/services/coupon_linked_to_term_service.dart';
import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/question_linked_to_tag_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/application/services/term_linked_to_tag_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/domain/answer.dart';
import 'package:beta/domain/answer_property.dart';
import 'package:beta/domain/config.dart';
import 'package:beta/domain/coupon.dart';
import 'package:beta/domain/coupon_linked_to_term.dart';
import 'package:beta/domain/ebook.dart';
import 'package:beta/domain/fcm_topic.dart';
import 'package:beta/domain/flashcard.dart';
import 'package:beta/domain/http_request.dart';
import 'package:beta/domain/image.dart';
import 'package:beta/domain/question.dart';
import 'package:beta/domain/question_linked_to_tag.dart';
import 'package:beta/domain/question_media.dart';
import 'package:beta/domain/question_property.dart';
import 'package:beta/domain/question_tag.dart';
import 'package:beta/domain/question_tag_property.dart';
import 'package:beta/domain/related_term.dart';
import 'package:beta/domain/term.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_label.dart';
import 'package:beta/domain/term_last_access.dart';
import 'package:beta/domain/term_linked_to_label.dart';
import 'package:beta/domain/term_linked_to_tag.dart';
import 'package:beta/domain/term_linked_to_tag_data.dart';
import 'package:beta/domain/term_parent.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/term_property.dart';
import 'package:beta/domain/term_tag.dart';
import 'package:beta/domain/term_tag_data.dart';
import 'package:beta/domain/term_tree.dart';
import 'package:beta/domain/term_with_questions_filtering_enabled.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/domain/video_file.dart';
import 'package:beta/domain/voice_note.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';

part 'database_service.g.dart'; // the generated code will be there

@DriftDatabase(tables: [
  Coupons,
  Terms,
  Answers,
  Questions,
  QuestionTags,
  QuestionMedias,
  FcmTopics,
  AnswerProperties,
  CouponsLinkedToTerms,
  TermTrees,
  Ebooks,
  TermsLastAccesses,
  QuestionTagProperties,
  QuestionProperties,
  HttpRequests,
  TermsWithQuestionsFilteringEnabled,
  Flashcards,
  VoiceNotes,
  VideoFiles,
  RelatedTerms,
  QuestionsLinkedToTags,
  TermsParents,
  TermTags,
  TermsLinkedToTags,
  TermLabels,
  TermsLinkedToLabels,
  TermProperties,
  Configs,
  Images
])
class DatabaseService extends _$DatabaseService {
  DatabaseService(super.e);

  @override
  int get schemaVersion => 42;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        List<String> migrationStatements = [];
        if (from < 2) {
          migrationStatements.add(
              'CREATE TABLE IF NOT EXISTS `ebooks` (`url` TEXT, `parentTermId` INTEGER NOT NULL, `creation` TEXT, PRIMARY KEY(`parentTermId`))');
        }
        if (from < 3) {
          migrationStatements.addAll([
            'create table `ebooksBackUp` (`parentTermId` INTEGER NOT NULL, `creation` TEXT, PRIMARY KEY(`parentTermId`))',
            'insert into `ebooksBackUp` select parentTermId,creation from ebooks',
            'drop table ebooks',
            'CREATE TABLE IF NOT EXISTS `ebooks` (`encryptionKey` TEXT, `parentTermId` INTEGER NOT NULL, `creation` TEXT, PRIMARY KEY(`parentTermId`))',
            'insert into `ebooks` (parentTermId,creation) select parentTermId,creation from ebooksBackUp',
            'drop table ebooksBackUp'
          ]);
        }
        if (from < 4) {
          migrationStatements.addAll([
            'ALTER TABLE `terms` ADD `enabled` INT NOT NULL DEFAULT 1 ',
            'ALTER TABLE `coupons` ADD `free` INTEGER NOT NULL DEFAULT 1'
          ]);
        }
        if (from < 5) {
          migrationStatements.add(
              'alter table `ebooks` add `downloadSize` Int not null default 0');
        }
        if (from < 6) {
          migrationStatements
              .add('alter table `terms` add `ordering` Int not null default 0');
        }
        if (from < 7) {
          migrationStatements.add(
              'alter table `terms` add `needsUpdate` INTEGER NOT NULL DEFAULT 0');
        }
        if (from < 8) {
          migrationStatements.add(
              'CREATE TABLE IF NOT EXISTS `questionTagProperties` (`questionTagId` INTEGER NOT NULL, `name` TEXT NOT NULL, `value` TEXT, PRIMARY KEY(`questionTagId`, `name`))');
        }
        if (from < 9) {
          migrationStatements.add(
              'CREATE TABLE IF NOT EXISTS `questionProperties` (`questionId` INTEGER NOT NULL, `name` TEXT NOT NULL, `value` TEXT, PRIMARY KEY(`questionId`, `name`))');
        }
        if (from < 10) {
          migrationStatements.addAll([
            'alter table `questions` add `edited` INTEGER not null default 0',
            'alter table `questions` add `editionDate` text '
          ]);
        }
        if (from < 11) {
          migrationStatements.add(
              'alter table `terms` add `captureable` INTEGER not null default 1');
        }
        if (from < 12) {
          migrationStatements.add(
              'alter table `questionTags` add `parentTagId` INTEGER NOT NULL DEFAULT 0');
        }
        if (from < 13) {
          migrationStatements.add(
              'ALTER TABLE `answers` ADD `checkedCount` INTEGER  not null DEFAULT 0');
        }
        if (from < 14) {
          migrationStatements.add(
              'ALTER TABLE `answers` ADD `userChecked` INTEGER not null DEFAULT 0');
        }
        if (from < 15) {
          migrationStatements.add(
              'CREATE TABLE IF NOT EXISTS `HttpRequests` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `url` TEXT, `map` TEXT)');
        }
        if (from < 16) {
          migrationStatements.add(
              'create index parentQuestionIdIndex on answers (parentQuestionId)');
        }
        if (from < 17) {
          migrationStatements.addAll([
            'create index questionMediasIndex1 on questionMedias (parentQuestionId)',
            'create index questionTagsIndex1 on questionTags (parentQuestionId)'
          ]);
        }
        if (from < 18) {
          migrationStatements.add(
              'CREATE TABLE IF NOT EXISTS `termsWithQuestionsFilteringEnabled` (`termId` INTEGER NOT NULL, PRIMARY KEY(`termId`))');
        }
        if (from < 19) {
          migrationStatements
              .add('ALTER TABLE `questionTags` ADD `information` TEXT');
        }
        if (from < 20) {
          migrationStatements.add(
              'CREATE TABLE IF NOT EXISTS `flashcards` (`id` INTEGER NOT NULL, `head` TEXT, `tail` TEXT, `parentTermId` INTEGER NOT NULL, PRIMARY KEY(`id`))');
        }
        if (from < 21) {
          migrationStatements.add('ALTER TABLE `terms` ADD `text` TEXT');
        }
        if (from < 22) {
          migrationStatements.addAll([
            "alter table `answers` add `titleTranslation` TEXT DEFAULT ''",
            "alter table `questions` add `titleTranslation` TEXT DEFAULT ''",
            "alter table `questions` add `noteTranslation` TEXT DEFAULT ''"
          ]);
        }
        if (from < 23) {
          migrationStatements.addAll([
            'alter table `coupons` add `activationDate` TEXT',
            'alter table `coupons` add `expirationDays` INTEGER NOT NULL default -1'
          ]);
        }
        if (from < 24) {
          migrationStatements.addAll([
            'CREATE TABLE IF NOT EXISTS `ebooksBackup` (`encryptionKey` TEXT, `parentTermId` INTEGER NOT NULL, `creation` TEXT, PRIMARY KEY(`parentTermId`))',
            'insert into `ebooksBackUp`(parentTermId,creation,encryptionKey) select parentTermId,creation,encryptionKey from ebooks ',
            'drop table ebooks',
            'CREATE TABLE IF NOT EXISTS `ebooks` (`encryptionKey` TEXT, `parentTermId` INTEGER NOT NULL, `creation` TEXT, PRIMARY KEY(`parentTermId`))',
            'insert into `ebooks` (parentTermId,creation,encryptionKey) select parentTermId,creation,encryptionKey from ebooksBackUp ',
            'drop table ebooksBackUp'
          ]);
        }
        if (from < 25) {
          migrationStatements
              .add('alter table `terms` add `free` INTEGER NOT NULL default 1');
        }
        if (from < 26) {
          migrationStatements.addAll([
            'PRAGMA foreign_keys=off',
            'BEGIN TRANSACTION',
            'CREATE TABLE IF NOT EXISTS `termsBackup` (`id` INTEGER NOT NULL, `uuid` TEXT, `parentTermId` INTEGER NOT NULL, `rootTermId` INTEGER NOT NULL, `layer` INTEGER NOT NULL, `name` TEXT, `tag` TEXT, `label` TEXT, `type` INTEGER NOT NULL, `creation` TEXT, `enabled` INTEGER NOT NULL DEFAULT 1, `free` INTEGER NOT NULL, `ordering` INTEGER NOT NULL, `needsUpdate` INTEGER NOT NULL DEFAULT 0, `captureable` INTEGER NOT NULL DEFAULT 1, `text` TEXT, PRIMARY KEY(`id`, `parentTermId`, `rootTermId`))',
            'insert into `termsBackup` select * from terms ',
            'drop table terms',
            'CREATE TABLE IF NOT EXISTS `terms` (`id` INTEGER NOT NULL, `uuid` TEXT, `parentTermId` INTEGER NOT NULL, `rootTermId` INTEGER NOT NULL, `layer` INTEGER NOT NULL, `name` TEXT, `tag` TEXT, `label` TEXT, `type` INTEGER NOT NULL, `creation` TEXT, `enabled` INTEGER NOT NULL DEFAULT 1, `free` INTEGER NOT NULL, `ordering` INTEGER NOT NULL, `needsUpdate` INTEGER NOT NULL DEFAULT 0, `captureable` INTEGER NOT NULL DEFAULT 1, `text` TEXT, PRIMARY KEY(`id`, `parentTermId`, `rootTermId`))',
            'insert into terms select * from termsBackup',
            'drop table termsBackup',
            'COMMIT',
            'PRAGMA foreign_keys=on'
          ]);
        }
        if (from < 27) {
          migrationStatements.add(
              "insert into answerProperties (answerId,name,value) select id,'userChecked','true' from answers where userChecked=1");
        }
        if (from < 28) {
          migrationStatements.addAll([
            "PRAGMA foreign_keys=off",
            "BEGIN TRANSACTION",
            "CREATE TABLE IF NOT EXISTS `answersBackup` (`id` INTEGER NOT NULL, `uuid` TEXT, `title` TEXT, `titleTranslation` TEXT DEFAULT '', `isCorrect` INTEGER NOT NULL, `parentQuestionId` INTEGER NOT NULL, `specialCharacter` INTEGER NOT NULL, `creation` TEXT, `checkedCount` INTEGER NOT NULL DEFAULT 0, PRIMARY KEY(`id`))",
            "insert into `answersBackup` (id,uuid,title,titleTranslation,isCorrect,parentQuestionId,specialCharacter,creation,checkedCount) select id,uuid,title,titleTranslation,isCorrect,parentQuestionId,specialCharacter,creation,checkedCount from answers",
            "drop table answers",
            "CREATE TABLE IF NOT EXISTS `answers` (`id` INTEGER NOT NULL, `uuid` TEXT, `title` TEXT, `titleTranslation` TEXT DEFAULT '', `isCorrect` INTEGER NOT NULL, `parentQuestionId` INTEGER NOT NULL, `specialCharacter` INTEGER NOT NULL, `creation` TEXT, `checkedCount` INTEGER NOT NULL DEFAULT 0, PRIMARY KEY(`id`))",
            "insert into answers select * from answersBackup",
            "drop table answersBackup",
            "COMMIT",
            "PRAGMA foreign_keys=on"
          ]);
        }
        if (from < 29) {
          migrationStatements.add(
              'create index parentQuestionIdIndex on answers (parentQuestionId)');
        }
        if (from < 30) {
          migrationStatements.addAll([
            "CREATE INDEX IF NOT EXISTS `answersIndex1` ON `answerProperties` (`answerId`)",
            "CREATE INDEX IF NOT EXISTS `qIndex1` ON `questions` (`parentTermId`)",
            "CREATE INDEX IF NOT EXISTS `qpIndex1` ON `questionProperties` (`questionId`)",
            "CREATE INDEX IF NOT EXISTS `questionTagsIndex2` ON `questionTags` (`parentTagId`)",
            "CREATE INDEX IF NOT EXISTS `qtpIndex1` ON `questionTagProperties` (`questionTagId`)"
          ]);
        }
        if (from < 31) {
          migrationStatements.add(
              "CREATE TABLE IF NOT EXISTS `voiceNotes` (`encryptionKey` BLOB, `parentTermId` INTEGER NOT NULL, `creation` TEXT, `lastUpdated` TEXT, `needsUpdate` INTEGER NOT NULL DEFAULT 0, PRIMARY KEY(`parentTermId`))");
        }
        if (from < 32) {
          migrationStatements.addAll([
            "CREATE TABLE IF NOT EXISTS `ebooksBackup` (`encryptionKey` TEXT, `parentTermId` INTEGER NOT NULL, `creation` TEXT, `lastUpdated` TEXT, `needsUpdate` INTEGER NOT NULL DEFAULT 0, PRIMARY KEY(`parentTermId`))",
            "insert into `ebooksBackUp`(parentTermId,creation,encryptionKey,lastUpdated,needsUpdate) select parentTermId,creation,encryptionKey,creation,0 from ebooks ",
            "drop table ebooks",
            "CREATE TABLE IF NOT EXISTS `ebooks` (`encryptionKey` TEXT, `parentTermId` INTEGER NOT NULL, `creation` TEXT, `lastUpdated` TEXT, `needsUpdate` INTEGER NOT NULL DEFAULT 0, PRIMARY KEY(`parentTermId`))",
            "insert into `ebooks` (parentTermId,creation,encryptionKey,lastUpdated,needsUpdate) select parentTermId,creation,encryptionKey,lastUpdated,needsUpdate from ebooksBackUp ",
            "drop table ebooksBackUp"
          ]);
        }
        if (from < 33) {
          migrationStatements.addAll([
            "CREATE TABLE IF NOT EXISTS `questionTagsBackup` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `parentQuestionId` INTEGER NOT NULL, `parentTagId` INTEGER NOT NULL DEFAULT 0, `hasInformation` INTEGER NOT NULL, `information` TEXT NOT NULL, `creation` TEXT, PRIMARY KEY(`id`, `parentQuestionId`))",
            "insert into questionTagsBackup (id,name,parentQuestionId,parentTagId,hasInformation,information,creation)  select id,name,parentQuestionId,parentTagId,0,information,creation from questionTags",
            "update questionTagsBackup set hasInformation=1 where length(information)>0",
            "drop table questionTags",
            "CREATE TABLE IF NOT EXISTS `questionTags` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `parentQuestionId` INTEGER NOT NULL, `parentTagId` INTEGER NOT NULL DEFAULT 0, `hasInformation` INTEGER NOT NULL DEFAULT 0, `creation` TEXT, PRIMARY KEY(`id`, `parentQuestionId`))",
            "insert into questionTags (id,name,parentQuestionId,parentTagId,hasInformation,creation)  select id,name,parentQuestionId,parentTagId,hasInformation,creation from questionTagsBackup",
            "drop table questionTagsBackup",
            "CREATE INDEX IF NOT EXISTS `questionTagsIndex2` ON `questionTags` (`parentTagId`)",
            "create index questionTagsIndex1 on questionTags (parentQuestionId)"
          ]);
        }
        if (from < 34) {
          migrationStatements.addAll([
            "CREATE TABLE IF NOT EXISTS `questionsLinkedToTags` (`questionId` INTEGER NOT NULL, `tagId` INTEGER NOT NULL, PRIMARY KEY(`questionId`, `tagId`) )",
            "CREATE INDEX IF NOT EXISTS `qlttIndex1` ON `questionsLinkedToTags` (`questionId`)",
            "CREATE INDEX IF NOT EXISTS `qlttIndex2` ON `questionsLinkedToTags` (`tagId`)",
            "insert into questionsLinkedToTags (questionId,tagId) select parentQuestionId,id from questionTags",
            "CREATE TABLE IF NOT EXISTS `questionTagsBackup` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `parentTagId` INTEGER NOT NULL DEFAULT 0, `hasInformation` INTEGER NOT NULL DEFAULT 0, `creation` TEXT, PRIMARY KEY(`id`))",
            "insert or ignore into questionTagsBackup (id,name,parentTagId,hasInformation,creation)  select id,name,parentTagId,hasInformation,creation from questionTags",
            "drop table questionTags",
            "CREATE TABLE IF NOT EXISTS `questionTags` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `parentTagId` INTEGER NOT NULL DEFAULT 0, `hasInformation` INTEGER NOT NULL DEFAULT 0, `creation` TEXT, PRIMARY KEY(`id`))",
            "insert or ignore into questionTags (id,name,parentTagId,hasInformation,creation)  select id,name,parentTagId,hasInformation,creation from questionTagsBackup",
            "drop table questionTagsBackup",
            "CREATE INDEX IF NOT EXISTS `questionTagsIndex1` ON `questionTags` (`parentTagId`)"
          ]);
        }
        if (from < 35) {
          migrationStatements.addAll([
            "CREATE TABLE IF NOT EXISTS `questionsBackup` (`id` INTEGER NOT NULL, `uuid` TEXT, `title` TEXT, `titleTranslation` TEXT DEFAULT '', `labelId` INTEGER NOT NULL, `note` TEXT, `noteTranslation` TEXT DEFAULT '', `parentTermId` INTEGER NOT NULL, `specialCharacter` INTEGER NOT NULL, `type` INTEGER NOT NULL, `edited` INTEGER NOT NULL DEFAULT 0, `imageUrl` TEXT DEFAULT '', `creation` TEXT, `editionDate` TEXT, PRIMARY KEY(`id`))",
            "insert into questionsBackup (id,uuid,title,titleTranslation,labelId,note,noteTranslation,parentTermId,specialCharacter,type,edited,creation,editionDate) select id,uuid,title,titleTranslation,labelId,note,noteTranslation,parentTermId,specialCharacter,type,edited,creation,editionDate from questions",
            "drop table questions",
            "CREATE TABLE IF NOT EXISTS `questions` (`id` INTEGER NOT NULL, `uuid` TEXT, `title` TEXT, `titleTranslation` TEXT DEFAULT '', `labelId` INTEGER NOT NULL, `note` TEXT, `noteTranslation` TEXT DEFAULT '', `parentTermId` INTEGER NOT NULL, `specialCharacter` INTEGER NOT NULL, `type` INTEGER NOT NULL, `edited` INTEGER NOT NULL DEFAULT 0, `imageUrl` TEXT DEFAULT '', `creation` TEXT, `editionDate` TEXT, PRIMARY KEY(`id`))",
            "CREATE INDEX IF NOT EXISTS `qIndex1` ON `questions` (`parentTermId`)",
            "insert into questions select * from questionsBackup",
            "drop table questionsBackup"
          ]);
        }
        if (from < 36) {
          migrationStatements.add(
              "CREATE TABLE IF NOT EXISTS `relatedTerms` (`anotherTermId` INTEGER NOT NULL, `termId` INTEGER NOT NULL, PRIMARY KEY(`anotherTermId`, `termId`))");
        }
        if (from < 37) {
          migrationStatements.addAll([
            "PRAGMA foreign_keys=off",
            "CREATE TABLE IF NOT EXISTS `termsParents` (`termId` INTEGER NOT NULL, `parentTermId` INTEGER NOT NULL, `rootTermId` INTEGER NOT NULL, `creation` TEXT, PRIMARY KEY(`termId`, `parentTermId`, `rootTermId`))",
            "INSERT INTO `termsParents` (termId,parentTermId,rootTermId,creation) SELECT id,parentTermId,rootTermId,creation from terms",
            "CREATE TABLE IF NOT EXISTS `termsTags` (`id` INTEGER NOT NULL, `name` TEXT, `ordering` INTEGER NOT NULL DEFAULT 0, PRIMARY KEY(`id`))",
            "CREATE TABLE IF NOT EXISTS `termsLinkedToTags` (`termId` INTEGER NOT NULL, `tagId` INTEGER NOT NULL, PRIMARY KEY(`termId`, `tagId`))",
            "CREATE INDEX IF NOT EXISTS `tlttIndex1` ON `termsLinkedToTags` (`termId`)",
            "CREATE INDEX IF NOT EXISTS `tlttIndex2` ON `termsLinkedToTags` (`tagId`)",
            "CREATE TABLE IF NOT EXISTS `termsLabels` (`id` INTEGER NOT NULL, `name` TEXT, PRIMARY KEY(`id`))",
            "CREATE TABLE IF NOT EXISTS `termsLinkedToLabels` (`termId` INTEGER NOT NULL, `labelId` INTEGER NOT NULL, PRIMARY KEY(`termId`, `labelId`))",
            "CREATE INDEX IF NOT EXISTS `tltlIndex1` ON `termsLinkedToLabels` (`termId`)",
            "CREATE INDEX IF NOT EXISTS `tltlIndex2` ON `termsLinkedToLabels` (`labelId`)",
            "CREATE TABLE IF NOT EXISTS `ebooksBackup` (`encryptionKey` TEXT, `parentTermId` INTEGER NOT NULL, `creation` TEXT, `lastUpdated` TEXT, PRIMARY KEY(`parentTermId`))",
            "INSERT INTO `ebooksBackup` (encryptionKey,parentTermId,creation,lastUpdated) select encryptionKey,parentTermId,creation,lastUpdated from ebooks",
            "drop table ebooks",
            "CREATE TABLE IF NOT EXISTS `ebooks` (`encryptionKey` TEXT, `parentTermId` INTEGER NOT NULL, `creation` TEXT, `lastUpdated` TEXT, PRIMARY KEY(`parentTermId`))",
            "INSERT INTO `ebooks` (encryptionKey,parentTermId,creation,lastUpdated) select encryptionKey,parentTermId,creation,lastUpdated from ebooksBackup",
            "drop table ebooksBackup",
            "CREATE TABLE IF NOT EXISTS `voiceNotesBackup` (`encryptionKey` BLOB, `parentTermId` INTEGER NOT NULL, `creation` TEXT, `lastUpdated` TEXT, PRIMARY KEY(`parentTermId`))",
            "INSERT INTO `voiceNotesBackup` (encryptionKey,parentTermId,creation,lastUpdated) select encryptionKey,parentTermId,creation,lastUpdated from voiceNotes",
            "drop table voiceNotes",
            "CREATE TABLE IF NOT EXISTS `voiceNotes` (`encryptionKey` BLOB, `parentTermId` INTEGER NOT NULL, `creation` TEXT, `lastUpdated` TEXT, PRIMARY KEY(`parentTermId`))",
            "INSERT INTO `voiceNotes` (encryptionKey,parentTermId,creation,lastUpdated) select encryptionKey,parentTermId,creation,lastUpdated from voiceNotesBackup",
            "drop table voiceNotesBackup",
            "CREATE TABLE IF NOT EXISTS `termsBackup` (`id` INTEGER NOT NULL, `uuid` TEXT, `parentTermId` INTEGER NOT NULL, `rootTermId` INTEGER NOT NULL, `layer` INTEGER NOT NULL, `name` TEXT, `tag` TEXT, `label` TEXT, `type` INTEGER NOT NULL, `creation` TEXT, `enabled` INTEGER NOT NULL DEFAULT 1, `free` INTEGER NOT NULL, `ordering` INTEGER NOT NULL, `needsUpdate` INTEGER NOT NULL DEFAULT 0, `captureable` INTEGER NOT NULL DEFAULT 1, `text` TEXT, PRIMARY KEY(`id`, `parentTermId`, `rootTermId`))",
            "insert into `termsBackup` select * from terms ",
            "drop table terms",
            "CREATE TABLE IF NOT EXISTS `terms` (`id` INTEGER NOT NULL, `uuid` TEXT, `name` TEXT, `type` INTEGER NOT NULL, `creation` TEXT, `enabled` INTEGER NOT NULL DEFAULT 1, `free` INTEGER NOT NULL, `ordering` INTEGER NOT NULL, `needsUpdate` INTEGER NOT NULL DEFAULT 0, `captureable` INTEGER NOT NULL DEFAULT 1, `text` TEXT, PRIMARY KEY(`id`))",
            "insert into terms (`id`,`uuid`,`name`,`type`,`creation`,`enabled`,`free`,`ordering`,`needsUpdate`,`captureable`,`text`) select `id`,`uuid`,`name`,`type`,`creation`,`enabled`,`free`,`ordering`,`needsUpdate`,`captureable`,`text` from termsBackup",
            "drop table termsBackup",
            "PRAGMA foreign_keys=on",
          ]);
        }
        // await transaction(() async {
        for (String statement in migrationStatements) {
          await m.database.executor.runCustom(statement);
        }
        if (from < 38) {
          await m.dropColumn(coupons, 'layer');
          await m.dropColumn(coupons, 'numberOfObjects');
          await m.dropColumn(coupons, 'rootTermId');

          await m.dropColumn(fcmTopics, 'subscribed');

          await m.createTable(termProperties);

          await m.database.executor
              .runCustom('ALTER TABLE voiceNotes RENAME TO temp_table');
          await m.database.executor.runCustom(
              'CREATE TABLE IF NOT EXISTS `voiceNotes` (`encryptionKey` TEXT, `parentTermId` INTEGER NOT NULL, `creation` TEXT, `lastUpdated` TEXT, PRIMARY KEY(`parentTermId`))');
          await m.database.executor.runCustom(
              "insert into voiceNotes (encryptionKey,parentTermId,creation,lastUpdated) select CAST(encryptionKey as TEXT),parentTermId,creation,lastUpdated from temp_table");
          await m.database.executor.runCustom("DROP TABLE temp_table");
        }
        if (from < 39) {
          await m.addColumn(terms, terms.outerNote);
        }
        if (from < 40) {
          await m.createTable(configs);
        }
        if (from < 41) await m.createTable(videoFiles);
        if (from < 42) await m.createTable(images);
      },
    );
  }

  Future deleteAllTables() async {
    for (var table in allTables) {
      await table.deleteAll();
    }
  }

  Future seedTermsData() async {
    TermService termService = Get.find();
    TermsParentService termsParentService = Get.find();
    CouponService couponService = Get.find();
    CouponLinkedToTermService couponLinkedToTermService = Get.find();
    await termService.addTerms([
      TermData(
          const Term(
              name: 'parent',
              enabled: 1,
              id: 1,
              uuid: 'a',
              type: 0,
              creation: '2022-01-01 11:11:11',
              free: 1,
              ordering: 1,
              needsUpdate: 0,
              captureable: 1,
              textCulumn: '',
              outerNote: 'outer note'),
          deletedAt: const DeletedAt(null),
          visible: const Visible(1)),
      TermData(
          const Term(
              name: 'child',
              enabled: 1,
              id: 2,
              uuid: 'a',
              type: 0,
              creation: '2022-01-01 11:11:11',
              free: 1,
              ordering: 1,
              needsUpdate: 0,
              captureable: 1,
              textCulumn: '',
              outerNote: ''),
          deletedAt: const DeletedAt(null),
          visible: const Visible(1)),
      TermData(
          const Term(
              name: 'grand child',
              enabled: 1,
              id: 3,
              uuid: 'a',
              type: 0,
              creation: '2022-01-01 11:11:11',
              free: 1,
              ordering: 1,
              needsUpdate: 0,
              captureable: 1,
              textCulumn: '',
              outerNote: ''),
          deletedAt: const DeletedAt(null),
          visible: const Visible(1))
    ]);
    await termsParentService.addTermsParents([
      TermsParentData(
          const TermsParent(
              termId: 1,
              parentTermId: -1,
              rootTermId: -1,
              creation: '2024-01-01 13:13:13'),
          deletedAt: const DeletedAt(null)),
      TermsParentData(
          const TermsParent(
              termId: 2,
              parentTermId: 1,
              rootTermId: -1,
              creation: '2024-01-01 13:13:13'),
          deletedAt: const DeletedAt(null)),
      TermsParentData(
          const TermsParent(
              termId: 3,
              parentTermId: 2,
              rootTermId: -1,
              creation: '2024-01-01 13:13:13'),
          deletedAt: const DeletedAt(null))
    ]);
    await couponService.addCoupon(const Coupon(
        id: 1,
        serial: 'serial',
        type: 1,
        free: 0,
        creation: '2023-01-01 11:12:13',
        activationDate: '2024-01-01 11:12:13',
        expirationDays: 100));
    await couponLinkedToTermService.addCouponLinkedToTerm(
        const CouponsLinkedToTerm(couponId: 1, termId: 1));
  }

  Future seedQuestionsTagsData() async {
    TermTagService tagService = Get.find();
    TermLinkedToTagService termLinkedToTagService = Get.find();
    QuestionTagService questionTagService = Get.find();
    QuestionService questionService = Get.find();
    QuestionLinkedToTagService questionLinkedToTagService = Get.find();
    await tagService.addTermTags([
      TermTagData(const TermTag(id: 1, name: 'tag name', ordering: 1),
          deletedAt: const DeletedAt(null))
    ]);
    await termLinkedToTagService.addTermsLinkedToTags([
      TermLinkedToTagData(const TermsLinkedToTag(tagId: 1, termId: 2),
          deletedAt: const DeletedAt(null))
    ]);
    await questionTagService.addQuestionTags([
      const QuestionTag(
          id: 1,
          name: 'parent tag',
          parentTagId: 0,
          hasInformation: 0,
          creation: '2022-01-01 11:11:11'),
      const QuestionTag(
          id: 2,
          name: 'child tag',
          parentTagId: 1,
          hasInformation: 0,
          creation: '2022-01-01 11:11:11'),
      const QuestionTag(
          id: 3,
          name: 'grand child tag',
          parentTagId: 2,
          hasInformation: 0,
          creation: '2022-01-01 11:11:11'),
      const QuestionTag(
          id: 4,
          name: 'parent tag 2',
          parentTagId: 0,
          hasInformation: 1,
          creation: '2022-01-01 11:11:11'),
      const QuestionTag(
          id: 5,
          name: 'child tag 2',
          parentTagId: 1,
          hasInformation: 1,
          creation: '2022-01-01 11:11:11'),
    ]);
    await questionService.addQuestions([
      const Question(
          id: 1,
          uuid: 'random uuid',
          title: 'question title',
          titleTranslation: 'question title translation',
          labelId: 1,
          note: '',
          noteTranslation: '',
          parentTermId: 2,
          specialCharacter: 1,
          type: 1,
          edited: 0,
          imageUrl: '',
          creation: '2022-01-01 10:10:10',
          editionDate: '')
    ]);
    await questionLinkedToTagService.addQuestionsLinkdeToTags([
      const QuestionsLinkedToTag(questionId: 1, tagId: 1),
      const QuestionsLinkedToTag(questionId: 1, tagId: 2),
      const QuestionsLinkedToTag(questionId: 1, tagId: 3),
      const QuestionsLinkedToTag(questionId: 1, tagId: 4),
      const QuestionsLinkedToTag(questionId: 1, tagId: 5)
    ]);
  }
}
