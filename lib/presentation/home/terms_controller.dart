// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/download_service.dart';
import 'package:beta/application/services/ebook_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/application/services/path/shared.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/application/services/video_file_service.dart';
import 'package:beta/application/services/voice_note_service.dart';
import 'package:beta/common/exceptions.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/downlaod_item.dart';
import 'package:beta/domain/ebook_data.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/domain/video_file_data.dart';
import 'package:beta/domain/voice_note_data.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/presentation/dialogues/loding_dialogue.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/dialogues/yes_no_dialogue.dart';
import 'package:beta/presentation/home/actions_widget.dart';
import 'package:beta/presentation/home/question_tag_listing_controller.dart';
import 'package:beta/presentation/home/term_tag_listing_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class TermsController {
  List<TermData> termsDatas = [];
  List<TermTag> termsTags = [];
  List<TermTagButton> termTagButtons = [];
  List<QuestionTagData> questionTagDatas = [];
  // List<TermData> relatedTerms = [];

  final State state;

  TermsController({required this.state}) {
    Get.delete<TermsListingController>();
    Get.delete<TermTagListingController>();
    Get.delete<QuestionTagListingController>();
    Get.delete<TermsController>();
    Get.delete<TermData>(tag: 'relatedTerm');
    Get.put(this);
    Get.put(TermsListingController(state));
    Get.put(TermTagListingController(state));
    Get.put(QuestionTagListingController(state));
  }

  Future<List> fetch() {
    if (Get.isRegistered<TermData>(tag: 'relatedTerm')) {
      // return Future.value(relatedTerms);
      return Future.value(termsDatas);
    }
    return Future.value([]);
  }

  bool canPop() {
    if (Get.isRegistered<TermData>(tag: 'relatedTerm')) {
      return false;
    }
    TermsListingController termsListingController = Get.find();
    if (termsListingController.termsListing.isNotEmpty &&
        Get.isRegistered<TermData>(tag: 'source')) {
      if (termsListingController.termsListing.last ==
          Get.find<TermData>(tag: 'source')) {
        return false;
      }
    }
    return true;
  }

  Future onPopScoped() async {
    if (Get.isRegistered<TermData>(tag: 'relatedTerm')) {
      Get.delete<TermData>(tag: 'relatedTerm');
      // relatedTerms.clear();
      state.setState(() {});
    }
    TermsListingController termsListingController = Get.find();
    TermService termService = Get.find();
    if (termsListingController.termsListing.isNotEmpty &&
        Get.isRegistered<TermData>(tag: 'source')) {
      TermData termData = Get.find(tag: 'source');
      if (termsListingController.termsListing.last ==
          Get.find<TermData>(tag: 'source')) {
        TermTagService termTagService = Get.find();
        List<TermData> subTerms =
            await termService.getSubTerms(termData.term.id);
        List<TermTag> termsTags = await termTagService.getTermsTags(subTerms);
        state.setState(() {
          this.termsTags = termsTags;
          termsDatas = subTerms;
        });
        return;
      }
    }
    if (termsListingController.termsListing.isNotEmpty) {
      termsListingController.termsListing.removeLast();
      List<TermData> termsDatas;
      if (termsListingController.termsListing.isEmpty) {
        termsDatas = await termService.getFirstLayerTerms();
        state.setState(() {
          this.termsDatas = termsDatas;
          termsListingController.items = termsDatas;
        });
        return;
      }
      await Get.delete<TermData>();
      TermData termData = termsListingController.termsListing.last;
      Get.put(termData);
      termsDatas = await termService.getSubTerms(termData.term.id);
      state.setState(() {
        this.termsDatas = termsDatas;
        termsListingController.items = termsDatas;
      });
    }
  }

  Future showYouNeedToDownloadTermsDialogue(Function onDownloaded) async {
    TermService termService = Get.find();
    TermData termData = Get.find<TermData>();
    List<TermData> childTermsWithNoQuestions =
        await termService.getTermUndownloadedTermsWithQuestions(termData);
    if (childTermsWithNoQuestions.isEmpty) {
      onDownloaded.call();
    } else if (state.mounted) {
      List termsTags = this.termsTags.map((termTag) => termTag.name).toList();
      if (termTagButtons.contains(TermTagButton.others)) {
        termsTags.add(StringConstant.others.tr());
      }
      showYesNoDialogueDialog(state.context,
          title: '',
          description: StringConstant.pleaseDownloadAllTermsWithin
              .tr()
              .replaceFirst('(TERM_TAGS)', termsTags.join(', ')),
          onYesClicked: () async {
        GlobalKey<LoadingDialogState> globalKey = GlobalKey();
        final total = childTermsWithNoQuestions.length;

        // Show dialog with key
        showLoadingDialog(state.context,
            process: 0, total: total, key: globalKey);

        try {
          await Future.wait(
              childTermsWithNoQuestions.asMap().entries.map((entry) async {
            final term = entry.value;

            await downloadContent(term);

            // Update progress programmatically
            globalKey.currentState
                ?.updateProgress(globalKey.currentState!.currentProcess + 1);
          }));
          if (state.mounted) state.context.pop();
          onDownloaded.call();
        } catch (e) {
          if (state.mounted) state.context.pop();
        }
      }, onNoClicked: () {});
    }
  }

  Future downloadContent(TermData termData) {
    String getDownloadApi() {
      if (termData.term.type == TermType.ebook) {
        return ApiConstant.getEbook;
      } else if (termData.term.type == TermType.voiceNotes) {
        return ApiConstant.getVoice;
      } else if (termData.term.type == TermType.videoFile) {
        return ApiConstant.getVideoFile;
      }
      return ApiConstant.getTermContent;
    }

    Future setTermUpdated() async {
      TermService termService = Get.find();
      await termService.setTermUpdated(termData);
    }

    void onPreConnect() {
      if (Get.isRegistered<State<ActionsWidget>>(
          tag: termData.term.id.toString())) {
        State<ActionsWidget> state =
            Get.find<State<ActionsWidget>>(tag: termData.term.id.toString());
        if (state.mounted) {
          state.widget.termWidgetController.state.setState(
              () => state.widget.termWidgetController.downloading = true);
        }
      }
    }

    void onPostConnect() {
      if (Get.isRegistered<State<ActionsWidget>>(
          tag: termData.term.id.toString())) {
        State<ActionsWidget> state =
            Get.find<State<ActionsWidget>>(tag: termData.term.id.toString());
        if (state.mounted) {
          state.widget.termWidgetController.state.setState(
              () => state.widget.termWidgetController.downloading = false);
        }
      }
    }

    void onConnectionFailed() {
      if (Get.isRegistered<State<ActionsWidget>>(
          tag: termData.term.id.toString())) {
        State<ActionsWidget> state =
            Get.find<State<ActionsWidget>>(tag: termData.term.id.toString());
        if (state.mounted) {
          showOkDialogue(state.widget.termWidgetController.state.context,
              content: StringConstant.noConnection.tr());
        }
      }
    }

    void onMessageReceived(FailureResponse message) {
      if (Get.isRegistered<State<ActionsWidget>>(
          tag: termData.term.id.toString())) {
        State<ActionsWidget> state =
            Get.find<State<ActionsWidget>>(tag: termData.term.id.toString());
        if (state.mounted) {
          showOkDialogue(state.widget.termWidgetController.state.context,
              content: message.content);
        }
      }
    }

    String url = getDownloadApi();
    DownloadService downloadService = Get.find();
    return downloadService.startDownloads(DownloadItem(
        id: Id(termData.term.id),
        type: Types.term,
        url: url,
        fileName: termData.term.name,
        onDownload: () {
          if (TermType.hasFile(termData)) {
            return NetworkService(
              onPreConnect: () => onPreConnect(),
              onPostConnect: () => onPostConnect(),
              onConnectionSucceed: (body) async {
                String url = '';
                if (termData.term.type == TermType.ebook) {
                  EbookService ebookService = Get.find();
                  EbookData ebookData = EbookData.fromJson(body['ebook']);
                  ebookService.addEbook(ebookData);
                  url = ebookData.url!.toString();
                }
                if (termData.term.type == TermType.voiceNotes) {
                  VoiceNoteService voiceNoteService = Get.find();
                  VoiceNoteData voiceNoteData =
                      VoiceNoteData.fromJson(body['voice']);
                  voiceNoteService.addVoiceNote(voiceNoteData);
                  url = voiceNoteData.url!.toString();
                }
                if (termData.term.type == TermType.videoFile) {
                  VideoFileService videoFileService = Get.find();
                  VideoFileData videoFileData =
                      VideoFileData.fromJson(body['videoFile']);
                  videoFileService.addVideoFile(videoFileData);
                  url = videoFileData.url!.toString();
                }
                PathService pathService = Get.find();
                String filePath = await pathService
                    .getFileSupportPath(['term', termData.term.id.toString()]);
                await NetworkService(
                        onPreConnect: onPreConnect,
                        onPostConnect: onPostConnect,
                        onConnectionSucceed: (_) => setTermUpdated(),
                        onConnectionFailed: onConnectionFailed,
                        onMessageReceived: onMessageReceived)
                    .download(
                        url: url,
                        filePath: filePath,
                        onRecieveProgress: (int progress, int total) {
                          if (Get.isRegistered<State<ActionsWidget>>(
                              tag: termData.term.id.toString())) {
                            State<ActionsWidget> actionsWidgetState =
                                Get.find<State<ActionsWidget>>(
                                    tag: termData.term.id.toString());
                            if (actionsWidgetState.mounted) {
                              State state = actionsWidgetState
                                  .widget.termWidgetController.state;
                              if (state.mounted) {
                                state.setState(() {
                                  if (progress == total) {
                                    actionsWidgetState
                                        .widget
                                        .termWidgetController
                                        .downloadProgress = null;
                                    return;
                                  }
                                  actionsWidgetState.widget.termWidgetController
                                          .downloadProgress =
                                      progress.toDouble() / total.toDouble();
                                });
                              }
                            }
                          }
                        });
              },
              onConnectionFailed: onConnectionFailed,
              onMessageReceived: onMessageReceived,
            ).get(
                url:
                    url.replaceFirst('(TERM_ID)', termData.term.id.toString()));
          }
          if (TermType.hasContent(termData)) {
            return NetworkService(
                    onPreConnect: onPreConnect,
                    onPostConnect: onPostConnect,
                    onConnectionSucceed: (body) async {
                      TermService termService = Get.find();
                      await termService.storeTermContent(body).then((_) {
                        if (Get.isRegistered<State<ActionsWidget>>(
                            tag: termData.term.id.toString())) {
                          State<ActionsWidget> actionsWidgetState =
                              Get.find<State<ActionsWidget>>(
                                  tag: termData.term.id.toString());
                          if (actionsWidgetState.mounted) {
                            State state = actionsWidgetState
                                .widget.termWidgetController.state;
                            if (termData.term.type == TermType.flashcards) {
                              if (state.mounted) {
                                state.setState(() => actionsWidgetState
                                        .widget
                                        .termWidgetController
                                        .termData
                                        .numberOfFlashcards =
                                    NumberOfSubTerms(
                                        body['flashcards'].length));
                              }
                            } else {
                              if (state.mounted) {
                                state.setState(() => actionsWidgetState
                                        .widget
                                        .termWidgetController
                                        .termData
                                        .numberOfQuestions =
                                    NumberOfSubTerms(body['questions'].length));
                              }
                            }
                          }
                        }
                        setTermUpdated();
                      });
                    },
                    onConnectionFailed: onConnectionFailed,
                    onMessageReceived: onMessageReceived)
                .get(
                    url: url.replaceFirst(
                        '(TERM_ID)', termData.term.id.toString()));
          }
          throw UnsupportedValueException(termData.term.type.toString());
        }));
  }
}
