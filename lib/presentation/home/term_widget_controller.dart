// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/download_service.dart';
import 'package:beta/application/services/ebook_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/application/services/path/shared.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/term_property_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/application/services/voice_note_service.dart';
import 'package:beta/common/exceptions.dart';
import 'package:beta/configs/links.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/downlaod_item.dart';
import 'package:beta/domain/ebook_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/domain/voice_note_data.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/infrastructure/url_launcher_repository.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/ebook/ebook_screen.dart';
import 'package:beta/presentation/flashcards/flashcards_screen.dart';
import 'package:beta/presentation/home/actions_widget.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/voice_note/voice_note_screen.dart';
import 'package:beta/presentation/youtube_video/youtube_video_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class TermWidgetController {
  final int index;
  late TermData termData;
  bool isDownloaded = true;
  bool isNew = false;
  bool isStudied = false;
  bool isFavorite = false;
  State state;
  bool downloading = false;
  double? downloadProgress;
  late TermsListingController termsListingController;
  TermService termService = Get.find();
  TermTagService termTagService = Get.find();
  TermPropertyService termPropertyService = Get.find();
  EbookService ebookService = Get.find();
  VoiceNoteService voiceNoteService = Get.find();
  PathService pathService = Get.find();
  DownloadService downloadService = Get.find();

  TermWidgetController(this.state, {required this.index}) {
    termsListingController = Get.find<TermsListingController>();
    termData = termsListingController.items[index];
    configureNewBanner();
    configureIsDownloaded();
    configureIsStudied();
    configureIsFavorite();
  }

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

  Future<void> configureIsDownloaded() async {
    if (TermType.hasFile(termData)) {
      isDownloaded = await pathService
          .isFilePartsInSupport(['term', termData.term.id.toString()]);
      if (state.mounted) state.setState(() {});
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

  Future<void> updateStudied(bool value) async {
    if (value) {
      await termPropertyService.addTermToStudied(Id(termData.term.id));
    } else {
      await termPropertyService.removeTermFromStudied(Id(termData.term.id));
    }
    state.setState(() {
      isStudied = value;
    });
  }

  Future<void> updateFavorite(bool value) async {
    if (value) {
      await termPropertyService.addTermToFavorite(Id(termData.term.id));
    } else {
      await termPropertyService.removeTermFromFavorite(Id(termData.term.id));
    }
    state.setState(() {
      isFavorite = value;
    });
  }

  Future configureIsStudied() =>
      termPropertyService.isTermStudied(Id(termData.term.id)).then((value) {
        if (state.mounted) {
          state.setState(() {
            isStudied = value;
          });
        }
      });

  Future configureIsFavorite() =>
      termPropertyService.isTermFavorite(Id(termData.term.id)).then((value) {
        if (state.mounted) {
          state.setState(() {
            isFavorite = value;
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

  void _onPreConnect() {
    State<ActionsWidget> state =
        Get.find<State<ActionsWidget>>(tag: termData.term.id.toString());
    if (state.mounted) {
      state.widget.termWidgetController.state
          .setState(() => state.widget.termWidgetController.downloading = true);
    }
  }

  void _onPostConnect() {
    State<ActionsWidget> state =
        Get.find<State<ActionsWidget>>(tag: termData.term.id.toString());
    if (state.mounted) {
      state.widget.termWidgetController.state.setState(
          () => state.widget.termWidgetController.downloading = false);
    }
  }

  void _onConnectionFailed() {
    State<ActionsWidget> state =
        Get.find<State<ActionsWidget>>(tag: termData.term.id.toString());
    if (state.mounted) {
      showOkDialogue(state.widget.termWidgetController.state.context,
          content: StringConstant.noConnection.tr());
    }
  }

  void _onMessageReceived(FailureResponse message) {
    State<ActionsWidget> state =
        Get.find<State<ActionsWidget>>(tag: termData.term.id.toString());
    if (state.mounted) {
      showOkDialogue(state.widget.termWidgetController.state.context,
          content: message.content);
    }
  }

  Future _setTermUpdated() async {
    await termService.setTermUpdated(termData);
    State<ActionsWidget> actionsWidgetState =
        Get.find<State<ActionsWidget>>(tag: termData.term.id.toString());
    if (actionsWidgetState.mounted) {
      State state = actionsWidgetState.widget.termWidgetController.state;
      if (state.mounted) {
        state.setState(() {
          actionsWidgetState.widget.termWidgetController.termData.term =
              termData.term.copyWith(needsUpdate: 0);
          actionsWidgetState.widget.termWidgetController.isDownloaded = true;
        });
      }
    }
  }

  Future downloadContent() {
    String url = _getDownloadApi();
    return downloadService.startDownloads(DownloadItem(
        id: Id(termData.term.id),
        type: Types.term,
        url: url,
        fileName: termData.term.name,
        onDownload: () {
          if (TermType.hasFile(termData)) {
            return NetworkService(
              onPreConnect: () => _onPreConnect(),
              onPostConnect: () => _onPostConnect(),
              onConnectionSucceed: (body) async {
                String url = '';
                if (termData.term.type == TermType.ebook) {
                  EbookData ebookData = EbookData.fromJson(body['ebook']);
                  ebookService.addEbook(ebookData);
                  url = ebookData.url!.toString();
                }
                if (termData.term.type == TermType.voiceNotes) {
                  VoiceNoteData voiceNoteData =
                      VoiceNoteData.fromJson(body['voice']);
                  voiceNoteService.addVoiceNote(voiceNoteData);
                  url = voiceNoteData.url!.toString();
                }
                String filePath = await pathService
                    .getFileSupportPath(['term', termData.term.id.toString()]);
                await NetworkService(
                        onPreConnect: _onPreConnect,
                        onPostConnect: _onPostConnect,
                        onConnectionSucceed: (_) => _setTermUpdated(),
                        onConnectionFailed: _onConnectionFailed,
                        onMessageReceived: _onMessageReceived)
                    .download(
                        url: url,
                        filePath: filePath,
                        onRecieveProgress: (int progress, int total) {
                          State<ActionsWidget> actionsWidgetState =
                              Get.find<State<ActionsWidget>>(
                                  tag: termData.term.id.toString());
                          if (actionsWidgetState.mounted) {
                            State state = actionsWidgetState
                                .widget.termWidgetController.state;
                            if (state.mounted) {
                              state.setState(() {
                                if (progress == total) {
                                  actionsWidgetState.widget.termWidgetController
                                      .downloadProgress = null;
                                  return;
                                }
                                actionsWidgetState.widget.termWidgetController
                                        .downloadProgress =
                                    progress.toDouble() / total.toDouble();
                              });
                            }
                          }
                        });
              },
              onConnectionFailed: _onConnectionFailed,
              onMessageReceived: _onMessageReceived,
            ).get(
                url:
                    url.replaceFirst('(TERM_ID)', termData.term.id.toString()));
          }
          if (TermType.hasContent(termData)) {
            return NetworkService(
                    onPreConnect: _onPreConnect,
                    onPostConnect: _onPostConnect,
                    onConnectionSucceed: (body) async {
                      await termService.storeTermContent(body).then((_) {
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
                                  NumberOfSubTerms(body['flashcards'].length));
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
                          _setTermUpdated();
                        }
                      });
                    },
                    onConnectionFailed: _onConnectionFailed,
                    onMessageReceived: _onMessageReceived)
                .get(
                    url: url.replaceFirst(
                        '(TERM_ID)', termData.term.id.toString()));
          }
          throw UnsupportedValueException(termData.term.type.toString());
        }));
  }

  bool displayLabel() {
    if (termsListingController.termsLabels.isEmpty) return false;
    if (index == 0) return true;
    // if (termData.labelId == null) return false;
    TermData previousTermData = termsListingController.items[index - 1];
    return termData.labelId != previousTermData.labelId;
  }

  bool isDownloadingInBackground(TermData termData) => downloadService.downloads
      .where((download) =>
          download.id.value == termData.term.id && !download.completed)
      .isNotEmpty;

  String getLabelText() {
    List<TermLabel> labelsWithId = termsListingController.termsLabels
        .where((element) => element.id == termData.labelId!.value)
        .toList();
    if (labelsWithId.isNotEmpty) return labelsWithId.first.name;
    return StringConstant.others.tr();
  }

  Future<void> onTermClick() async {
    if (termData.term.enabled != 1) {
      showOkDialogue(state.context,
          onConfirm: () =>
              Get.find<UrlLauncherRepository>().openUrl(telegramChannelLink),
          content: StringConstant.contentLocked.tr());
      return;
    }
    TermLastAccessService termLastAccessService = Get.find();
    if (termData.term.type == TermType.term) {
      await Get.delete<TermData>();
      Get.put(termData);
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
    if (termData.term.type == TermType.term) {
      return;
    }
    switch (termData.term.type) {
      case TermType.questions:
      case TermType.template:
        if (isDownloaded) {
          if (termData.numberOfQuestions!.value! > 0) {
            Get.delete<QuestionsScreenArgument>();
            Get.put(QuestionsScreenArgument(
                query:
                    "q.parentTermId= '${termData.term.id}' ORDER BY q.id asc",
                source: QuestionScreenSource.term,
                sourceId: Id(termData.term.id),
                resourceTermId: Id(Get.isRegistered<TermData>(tag: 'source')
                    ? Get.find<TermData>(tag: 'source').term.id
                    : termData.term.id),
                title: t.Title(termData.term.name),
                termData: termData));
            if (state.mounted) state.context.push(QuestionsScreen.route);
          }
        } else {
          if (state.mounted) {
            showOkDialogue(state.context,
                content: StringConstant.youHaveToDownloadFirst.tr());
          }
        }
        break;
      case TermType.ebook:
        if (isDownloaded) {
          if (await termService.isUnExpired(termData)) {
            Get.delete<EbookScreenArgument>();
            Get.put(EbookScreenArgument(term: termData));
            if (state.mounted) state.context.push(EbookScreen.route);
          } else {
            if (state.mounted) {
              showOkDialogue(state.context,
                  content: StringConstant.termIsExpired.tr());
            }
          }
        } else {
          if (state.mounted) {
            showOkDialogue(state.context,
                content: StringConstant.youHaveToDownloadFirst.tr());
          }
        }
        break;
      case TermType.youtubeVideos:
        if (await termService.isUnExpired(termData) && state.mounted) {
          NetworkService(
            onPreConnect: _onPreConnect,
            onConnectionFailed: _onConnectionFailed,
            onMessageReceived: _onMessageReceived,
            onPostConnect: _onPostConnect,
            onConnectionSucceed: (body) {
              Get.delete<YoutubeVideoScreenArgument>();
              Get.put(YoutubeVideoScreenArgument(
                  termData: termData,
                  videoId: body['youtubeVideo']['videoId']));
              state.context.push(YoutubeVideoScreen.route);
              return Future.value();
            },
          ).get(
              url: ApiConstant.getYoutubeVideo
                  .replaceFirst('(TERM_ID)', termData.term.id.toString()));
        } else if (state.mounted) {
          showOkDialogue(state.context,
              content: StringConstant.termIsExpired.tr());
        }
        break;
      case TermType.flashcards:
        if (state.mounted) {
          if (isDownloaded) {
            Get.delete<FlashcardsScreenArgument>();
            Get.put(FlashcardsScreenArgument(
                query:
                    'select * from flashcards where parentTermId=${termData.term.id}',
                title: termData.term.name,
                term: termData));
            state.context.push(FlashcardsScreen.route);
          } else {
            showOkDialogue(state.context,
                content: StringConstant.youHaveToDownloadFirst.tr());
          }
        }
        break;
      case TermType.voiceNotes:
        if (isDownloaded) {
          if (await termService.isUnExpired(termData)) {
            Get.delete<VoiceNoteScreenArgument>();
            Get.put(VoiceNoteScreenArgument(term: termData));
            if (state.mounted) state.context.push(VoiceNoteScreen.route);
          } else {
            if (state.mounted) {
              showOkDialogue(state.context,
                  content: StringConstant.termIsExpired.tr());
            }
          }
        } else {
          if (state.mounted) {
            showOkDialogue(state.context,
                content: StringConstant.youHaveToDownloadFirst.tr());
          }
        }
        break;
      default:
        throw UnimplementedError();
    }
  }
}
