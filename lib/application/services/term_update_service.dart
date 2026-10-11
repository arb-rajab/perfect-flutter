import 'package:beta/application/services/download_service.dart';
import 'package:beta/application/services/ebook_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/application/services/path/shared.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/video_file_service.dart';
import 'package:beta/application/services/voice_note_service.dart';
import 'package:beta/common/exceptions.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/domain/downlaod_item.dart';
import 'package:beta/domain/ebook_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/video_file_data.dart';
import 'package:beta/domain/voice_note_data.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/infrastructure/connection_repository.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:get/instance_manager.dart';

/// Downloads and refreshes the content of downloadable terms, independently
/// of whether the term is currently shown on screen.
class TermUpdateService {
  final KeyValue keyValue;
  TermService termService = Get.find();
  EbookService ebookService = Get.find();
  VoiceNoteService voiceNoteService = Get.find();
  VideoFileService videoFileService = Get.find();
  PathService pathService = Get.find();
  DownloadService downloadService = Get.find();
  ConnectionRepository connectionRepository = Get.find();

  TermUpdateService({required this.keyValue});

  bool isAutoUpdateEnabled() => keyValue.getBool(
    KeyValueConstant.autoUpdateTerms,
    KeyValueConstant.autoUpdateTermsDefaultValue,
  )!;

  Future setAutoUpdateEnabled(bool value) =>
      keyValue.setBool(KeyValueConstant.autoUpdateTerms, value);

  DateTime? getLastUpdated(int termId) {
    String? value = keyValue.getString(
      '${KeyValueConstant.termLastUpdated}$termId',
    );
    return value == null ? null : DateTime.tryParse(value);
  }

  Future _setLastUpdated(int termId) => keyValue.setString(
    '${KeyValueConstant.termLastUpdated}$termId',
    DateTime.now().toIso8601String(),
  );

  Future<bool> isTermDownloaded(TermData termData) async {
    if (TermType.hasFile(termData)) {
      return pathService.isFilePartsInSupport([
        'term',
        termData.term.id.toString(),
      ]);
    }
    switch (termData.term.type) {
      case TermType.questions:
      case TermType.template:
        return (termData.numberOfQuestions?.value ?? 0) > 0;
      case TermType.flashcards:
        return (termData.numberOfFlashcards?.value ?? 0) > 0;
      case TermType.images:
        return (termData.numberOfImages?.value ?? 0) > 0;
    }
    return false;
  }

  /// Terms the user already downloaded that have newer content available.
  Future<List<TermData>> getDownloadedUpdateableTerms() async {
    List<TermData> terms = await termService.getUpdateableTerms();
    List<TermData> downloaded = [];
    for (TermData termData in terms) {
      if (TermType.downloadable(termData) && await isTermDownloaded(termData)) {
        downloaded.add(termData);
      }
    }
    return downloaded;
  }

  /// Silently updates downloaded terms. Small content (questions, flashcards,
  /// images) is always updated, files (ebooks, voice notes, videos) only on
  /// Wi-Fi.
  Future<void> autoUpdate({
    Future<void> Function(TermData termData)? onTermUpdated,
  }) async {
    if (!isAutoUpdateEnabled()) return;
    List<TermData> terms = await getDownloadedUpdateableTerms();
    if (!await connectionRepository.isOnWifi()) {
      terms = terms.where(TermType.hasContent).toList();
    }
    await updateTerms(terms, onTermUpdated: onTermUpdated);
  }

  Future<void> updateTerms(
    List<TermData> terms, {
    Future<void> Function(TermData termData)? onTermUpdated,
  }) async {
    for (TermData termData in terms) {
      await startDownload(
        termData,
        onUpdated: onTermUpdated == null
            ? null
            : () => onTermUpdated.call(termData),
      );
    }
  }

  bool isDownloading(TermData termData) => downloadService.downloads
      .where(
        (download) =>
            download.id.value == termData.term.id && !download.completed,
      )
      .isNotEmpty;

  Future startDownload(
    TermData termData, {
    Function()? onPreConnect,
    Function()? onPostConnect,
    Function()? onConnectionFailed,
    Function(FailureResponse message)? onMessageReceived,
    Function(int received, int total)? onReceiveProgress,
    Future<void> Function(dynamic body)? onContentStored,
    Future<void> Function()? onUpdated,
  }) {
    String url = _getDownloadApi(
      termData,
    ).replaceFirst('(TERM_ID)', termData.term.id.toString());
    return downloadService.startDownloads(
      DownloadItem(
        id: Id(termData.term.id),
        type: Types.term,
        url: url,
        fileName: termData.term.name,
        onDownload: () => _download(
          termData,
          url,
          onPreConnect: onPreConnect ?? () {},
          onPostConnect: onPostConnect ?? () {},
          onConnectionFailed: onConnectionFailed ?? () {},
          onMessageReceived: onMessageReceived ?? (_) {},
          onReceiveProgress: onReceiveProgress ?? (_, __) {},
          onContentStored: onContentStored,
          onUpdated: onUpdated,
        ),
      ),
    );
  }

  Future _download(
    TermData termData,
    String url, {
    required Function() onPreConnect,
    required Function() onPostConnect,
    required Function() onConnectionFailed,
    required Function(FailureResponse message) onMessageReceived,
    required Function(int received, int total) onReceiveProgress,
    Future<void> Function(dynamic body)? onContentStored,
    Future<void> Function()? onUpdated,
  }) async {
    Future<void> setUpdated() async {
      await termService.setTermUpdated(termData);
      await _setLastUpdated(termData.term.id);
      await onUpdated?.call();
    }

    if (TermType.hasFile(termData)) {
      return NetworkService(
        onPreConnect: onPreConnect,
        onPostConnect: onPostConnect,
        onConnectionSucceed: (body) async {
          String fileUrl = '';
          if (termData.term.type == TermType.ebook) {
            EbookData ebookData = EbookData.fromJson(body['ebook']);
            ebookService.addEbook(ebookData);
            fileUrl = ebookData.url!.toString();
          }
          if (termData.term.type == TermType.voiceNotes) {
            VoiceNoteData voiceNoteData = VoiceNoteData.fromJson(body['voice']);
            voiceNoteService.addVoiceNote(voiceNoteData);
            fileUrl = voiceNoteData.url!.toString();
          }
          if (termData.term.type == TermType.videoFile) {
            VideoFileData videoFileData = VideoFileData.fromJson(
              body['videoFile'],
            );
            videoFileService.addVideoFile(videoFileData);
            fileUrl = videoFileData.url!.toString();
          }
          String filePath = await pathService.getFileSupportPath([
            'term',
            termData.term.id.toString(),
          ]);
          await NetworkService(
            onPreConnect: onPreConnect,
            onPostConnect: onPostConnect,
            onConnectionSucceed: (_) => setUpdated(),
            onConnectionFailed: onConnectionFailed,
            onMessageReceived: onMessageReceived,
          ).download(
            url: fileUrl,
            filePath: filePath,
            onRecieveProgress: onReceiveProgress,
          );
        },
        onConnectionFailed: onConnectionFailed,
        onMessageReceived: onMessageReceived,
      ).get(url: url);
    }
    if (TermType.hasContent(termData)) {
      return NetworkService(
        onPreConnect: onPreConnect,
        onPostConnect: onPostConnect,
        onConnectionSucceed: (body) async {
          await termService.storeTermContent(body);
          await onContentStored?.call(body);
          await setUpdated();
        },
        onConnectionFailed: onConnectionFailed,
        onMessageReceived: onMessageReceived,
      ).get(url: url);
    }
    throw UnsupportedValueException(termData.term.type.toString());
  }

  String _getDownloadApi(TermData termData) {
    if (termData.term.type == TermType.ebook) {
      return ApiConstant.getEbook;
    } else if (termData.term.type == TermType.voiceNotes) {
      return ApiConstant.getVoice;
    } else if (termData.term.type == TermType.videoFile) {
      return ApiConstant.getVideoFile;
    }
    return ApiConstant.getTermContent;
  }
}
