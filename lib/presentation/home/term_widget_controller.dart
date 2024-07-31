// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously

import 'dart:io';

import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/ebook_service.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/application/services/question_linked_to_tag_service.dart';
import 'package:beta/application/services/question_media_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/term_property_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/application/services/voice_note_service.dart';
import 'package:beta/common/exceptions.dart';
import 'package:beta/configs/links.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/ebook_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/domain/voice_note_data.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/infrastructure/url_launcher_repository.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TermWidgetController {
  final int index;
  late TermData termData;
  bool isDownloaded = true;
  bool isNew = false;
  bool isStudied = false;
  State state;
  bool downloading = false;
  late File file;
  double downloadProgress = 0;
  late TermsListingController termsListingController;
  TermService termService = Get.find();
  TermTagService termTagService = Get.find();
  TermPropertyService termPropertyService = Get.find();

  TermWidgetController(this.state, {required this.index}) {
    termsListingController = Get.find<TermsListingController>();
    termData = termsListingController.items[index];
    configureNewBanner();
    configureIsDownloaded();
    configureIsStudied();
  }

//TODO add tests
  Future configureNewBanner() {
    TermLastAccessService termLastAccessService = Get.find();
    return termLastAccessService.isTermAccessed(termData).then((value) {
      if (state.mounted) {
        state.setState(() {
          isNew = !value;
        });
      }
    });
  }

  //TODO add tests
  Future<void> configureIsDownloaded() async {
    if (TermType.hasFile(termData)) {
      getApplicationSupportDirectory().then((value) async {
        file = File(join(value.path, 'term', termData.term.id.toString()));
        isDownloaded = await file.exists();
        if (state.mounted) state.setState(() {});
      });
    }
    if (termData.term.type == TermType.questions ||
        termData.term.type == TermType.template) {
      if (state.mounted) {
        state.setState(() {
        isDownloaded = termData.numberOfQuestions!.value! > 0;
      });
      }
    } else if (termData.term.type == TermType.flashcards) {
      if (state.mounted) {
        state.setState(() {
        isDownloaded = termData.numberOfFlashcards!.value! > 0;
      });
      }
    }
  }

  //TODO add tests
  Future<void> updateStudied(bool value) async {
    if (value) {
      await termPropertyService.addTermToStudied(termData);
    } else {
      await termPropertyService.removeTermFromStudied(termData);
    }
    state.setState(() {
      isStudied = value;
    });
  }

  //TODO add tests
  Future configureIsStudied() =>
      termPropertyService.isTermStudied(termData).then((value) {
        if (state.mounted) {
          state.setState(() {
            isStudied = value;
          });
        }
      });

  String _getDownloadApi() {
    if (termData.term.type == TermType.ebook) {
      return ApiConstant.getEbook;
    } else if (termData.term.type == TermType.voiceNotes) {
      return ApiConstant.getVoice;
    }
    return ApiConstant.getTermContent;
  }

  void _onPreConnect() => state.setState(() => downloading = true);
  void _onPostConnect() => state.setState(() => downloading = false);
  void _onConnectionFailed() =>
      showOkDialogue(state.context, () {},
      content: StringConstant.noConnection.tr());
  void _onMessageReceived(FailureResponse message) =>
      showOkDialogue(state.context, () {}, content: message.content);

  Future _setTermUpdated() async {
    TermService termService = Get.find();
    await termService.setTermUpdated(termData);
    state.setState(() {
      termData.term = termData.term.copyWith(needsUpdate: 0);
      isDownloaded = true;
    });
  }

  //TODO add tests
  Future<void> downloadContent() {
    String url = _getDownloadApi();

    if (TermType.hasFile(termData)) {
      return NetworkService(
        state.context,
        onPreConnect: () => _onPreConnect(),
        onPostConnect: () => _onPostConnect(),
        onConnectionSucceed: (body) {
          String url = '';
          if (termData.term.type == TermType.ebook) {
            EbookService ebookService = Get.find();
            EbookData ebookData = EbookData.fromJson(body['ebook']);
            ebookService.addEbook(ebookData);
            url = ebookData.url!.toString();
          }
          if (termData.term.type == TermType.voiceNotes) {
            VoiceNoteService voiceNoteService = Get.find();
            VoiceNoteData voiceNoteData = VoiceNoteData.fromJson(body['voice']);
            voiceNoteService.addVoiceNote(voiceNoteData);
            url = voiceNoteData.url!.toString();
          }
          NetworkService(state.context,
                  onPreConnect: _onPreConnect,
                  onPostConnect: _onPostConnect,
                  onConnectionSucceed: (_) => _setTermUpdated(),
                  onConnectionFailed: _onConnectionFailed,
                  onMessageReceived: _onMessageReceived)
              .download(
                  url: url,
                  file: file,
                  onRecieveProgress: (int progress, int total) =>
                      state.setState(() => downloadProgress =
                          progress.toDouble() / total.toDouble()));
        },
        onConnectionFailed: _onConnectionFailed,
        onMessageReceived: _onMessageReceived,
      ).get(url: url.replaceFirst('(TERM_ID)', termData.term.id.toString()));
    }
    if ([TermType.flashcards, TermType.questions, TermType.template]
        .contains(termData.term.type)) {
      return NetworkService(state.context,
              onPreConnect: _onPreConnect,
              onPostConnect: _onPostConnect, onConnectionSucceed: (body) async {
        List<Question> questions = (body['questions'] as List)
            .map((e) => Question.fromJson(e))
            .toList();
        List<Flashcard> flashcards = (body['flashcards'] as List)
            .map((e) => Flashcard.fromJson(e))
            .toList();
        List<Answer> answers =
            (body['answers'] as List).map((e) => Answer.fromJson(e)).toList();
        List<QuestionMedia> questionMedias = (body['media'] as List)
            .map((e) => QuestionMedia.fromJson(e))
            .toList();
        List<QuestionTag> questionTags = (body['questionTags'] as List)
            .map((e) => QuestionTag.fromJson(e))
            .toList();
        List<QuestionsLinkedToTag> questionsLinkedToTags =
            (body['questionsLinkedToTags'] as List)
                .map((e) => QuestionsLinkedToTag.fromJson(e))
                .toList();
        QuestionService questionService = Get.find();
        await questionService.addQuestions(questions);
        AnswerService answerService = Get.find();
        await answerService.addAnswers(answers);
        FlashcardService flashcardService = Get.find();
        await flashcardService.addFlashcards(flashcards);
        QuestionMediaService questionMediaService = Get.find();
        await questionMediaService.addQuestionMedias(questionMedias);
        QuestionTagService questionTagService = Get.find();
        await questionTagService.addQuestionTags(questionTags);
        QuestionLinkedToTagService questionLinkedToTagService = Get.find();
        await questionLinkedToTagService
            .addQuestionsLinkdeToTags(questionsLinkedToTags);
        if (termData.term.type == TermType.flashcards) {
          state.setState(() => termData.numberOfFlashcards =
              NumberOfSubTerms(flashcards.length));
        } else {
          state.setState(() =>
              termData.numberOfQuestions = NumberOfSubTerms(questions.length));
        }
        _setTermUpdated();
      },
              onConnectionFailed: _onConnectionFailed,
              onMessageReceived: _onMessageReceived)
          .get(url: url.replaceFirst('(TERM_ID)', termData.term.id.toString()));
    }
    throw UnsupportedValueException(termData.term.type.toString());
  }

  //TODO add tests
  bool displayLabel() {
    if (termsListingController.termsLabels.isEmpty) return false;
    if (index == 0) return true;
    // if (termData.labelId == null) return false;
    TermData previousTermData = termsListingController.items[index - 1];
    return termData.labelId != previousTermData.labelId;
  }

//TODO add tests
  String getLabelText() {
    List<TermLabel> labelsWithId = termsListingController.termsLabels
        .where((element) => element.id == termData.labelId!.value)
        .toList();
    if (labelsWithId.isNotEmpty) return labelsWithId.first.name;
    return StringConstant.others.tr();
  }

  //TODO add tests
  Future<void> onTermClick() async {
    if (termData.term.enabled != 1) {
      showOkDialogue(
          state.context,
          () => Get.find<UrlLauncherRepository>().openUrl(telegramChannelLink),
          content: StringConstant.contentLocked.tr());
      return;
    }
    TermLastAccessService termLastAccessService = Get.find();
    await Get.delete<TermData>();
    Get.put(termData);
    if (termData.term.type == TermType.term) {
      await termLastAccessService.addTermLastAccessed(
          Id(termData.term.id), Id(termData.term.id));
    }
    List<TermData> subTerms = await termService.getSubTerms(termData.term.id);
    List<TermTag> termsTags = await termTagService.getTermsTags(subTerms);
    TermsController termsController = Get.find();
    if (termsTags.isNotEmpty) {
      await Get.delete<TermData>(tag: 'source');
      Get.put(termData, tag: 'source');
      termsController.state.setState(() {
        termsController.termsTags = termsTags;
        termsController.termsDatas = subTerms;
        termsListingController.termsListing.add(termData);
        // tagListingController.items = termsTags;
      });
      return;
    }
    if (subTerms.isNotEmpty) {
      termsController.state.setState(() {
        termsController.termsDatas = subTerms;
        termsListingController.items = subTerms;
        termsListingController.termsListing.add(termData);
      });
      return;
    }
    if (termData.term.type == 0) return;
    Get.delete<QuestionsScreenArgument>();
    switch (termData.term.type) {
      case TermType.questions:
      case TermType.template:
        if (isDownloaded) {
          if (termData.numberOfQuestions!.value! > 0) {
            Get.put(QuestionsScreenArgument(
                query:
                    "q.parentTermId= '${termData.term.id}' ORDER BY q.id asc",
                source: QuestionScreenSource.term,
                sourceId: Id(termData.term.id),
                resourceTermId: Id(Get.find<TermData>(tag: 'source').term.id),
                title: t.Title(termData.term.name),
                termData: termData));
            state.context.push(QuestionsScreen.route);
          }
        } else {
          showOkDialogue(
              state.context, () {},
              content: StringConstant.youHaveToDownloadFirst.tr());
        }
        break;
      default: //TODO implement other terms types
        throw UnimplementedError();
    }
  }
}
