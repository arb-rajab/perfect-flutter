import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/infrastructure/screenshot_repository.dart';
import 'package:beta/presentation/discussion/discussion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class YoutubeVideoScreenController {
  final State state;
  YoutubeVideoScreenArgument argument = Get.find();
  ScreenshotRepository screenshotRepository = Get.find();
  TermLastAccessService termLastAccessService = Get.find();
  late InAppWebViewController controller;
  late int lastSecond;
  bool visible = false;
  bool finishedLoading = false;

  YoutubeVideoScreenController(this.state) {
    screenshotRepository.preventScreenshot();
  }

  Future<void> getLastSecond() async {
    TermsLastAccess? termLastAccess = await termLastAccessService
        .getTermLastAccess(argument.termData.term.id);
    lastSecond = 0;
    if (termLastAccess != null) lastSecond = termLastAccess.childId;
    controller.loadUrl(
        urlRequest: URLRequest(
            url: WebUri(
                "https://www.youtube.com/embed/${argument.videoId}?autoplay=1&start=$lastSecond")));
  }

  void onProgressChanged(InAppWebViewController controller, progress) {
    if (progress == 100 && !finishedLoading) {
      // ignore: invalid_use_of_protected_member
      state.setState(() {
        finishedLoading = true;
        visible = true;
      });
      controller.evaluateJavascript(
          source:
              "javascript:document.querySelector('.ytp-chrome-top').remove();");
      controller.evaluateJavascript(
          source:
              "javascript:document.querySelector('.ytp-large-play-button').remove();");
      controller.evaluateJavascript(
          source:
              "javascript:document.querySelector('.ytp-impression-link').remove();");
      controller.evaluateJavascript(
          source:
              "javascript:document.querySelector('.ytp-youtube-button').remove();");
      controller.evaluateJavascript(
          source:
              "javascript:document.body.setAttribute('oncopy','return false');");
      controller.evaluateJavascript(
          source: "javascript:"
              "setInterval(() => console.log('TIME:'+document.querySelector('.ytp-progress-bar').getAttribute('aria-valuenow')), 1000)");
      controller.evaluateJavascript(
          source: "javascript:"
              "setInterval(() => document.querySelector('.ytp-contextmenu').remove(),500);");
      controller.evaluateJavascript(
          source: "javascript:"
              "setInterval(() => document.querySelector('.ytp-sfn-cpn').remove(),500);");
    }
  }

  void dispose() {
    screenshotRepository.allowScreenshot();
  }

  void onConsoleMessage(controller, message) {
    if (message.message.startsWith("TIME:")) {
      String time = message.message.substring("TIME:".length);
      if (time != "0") {
        int lastAccessedSecond = int.parse(time);
        termLastAccessService.addTermLastAccessed(
            Id(argument.termData.term.id), Id(lastAccessedSecond));
        // if (destroyed) {
        //   youTubePlayerView.destroy();
        // }
      }
    }
  }

  void loadMoreCommentsTap() {
    Get.delete<DiscussionScreenArgument>();
    Get.put(DiscussionScreenArgument(
        itemId: argument.termData.term.id,
        itemType: "video",
        itemName: argument.termData.term.name));
    state.context.push(DiscussionScreen.route);
  }
}
