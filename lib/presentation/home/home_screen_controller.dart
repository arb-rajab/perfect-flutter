import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/fcm_topic_service.dart';
import 'package:beta/application/services/http_request_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/application/services/related_term_service.dart';
import 'package:beta/application/services/term_label_service.dart';
import 'package:beta/application/services/term_linked_to_label_service.dart';
import 'package:beta/application/services/term_linked_to_tag_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/application/services/terms_with_questions_filtering_enabled_service.dart';
import 'package:beta/application/services/user_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/domain/related_term_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_label_data.dart';
import 'package:beta/domain/term_linked_to_label_data.dart';
import 'package:beta/domain/term_linked_to_tag_data.dart';
import 'package:beta/domain/term_parent_data.dart';
import 'package:beta/domain/term_tag_data.dart';
import 'package:beta/domain/term_with_questions_filtering_enabled_properties.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/infrastructure/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:in_app_review/in_app_review.dart';

class HomeScreenController {
  final BuildContext context;
  UserService userService = Get.find();
  final PageController pageController = PageController();
  HomeScreenController(this.context) {
    configureUserToken();
    subscribeToTopics();
    subscribeToAllNotifications();
    executePendingRequests();
    recieveNewToken();
    showRequestReview();
    getTermsUpdates();
  }

  void getTermsUpdates() {
    NetworkService(context, onPreConnect: () {}, onPostConnect: () {},
            onConnectionSucceed: (data) async {
      List<TermData> updatedTerms = (data['updated-terms'] as List)
          .map((e) => TermData.fromJson(e))
          .toList();
      TermService termService = Get.find();
      await termService.addTerms(updatedTerms);

      List<Id> refreshedTermsIds = (data['refreshed-terms-ids'] as List)
          .map((e) => const IdJsonConverter().fromJson(e))
          .toList();
      await termService.setTermsNeedUpdate(refreshedTermsIds);

      List<RelatedTermData> relatedTerms = (data['related-terms'] as List)
          .map((e) => RelatedTermData.fromJson(e))
          .toList();
      RelatedTermService relatedTermService = Get.find();
      await relatedTermService.addRelatedTerms(relatedTerms);

      List<TermsWithQuestionsFilteringEnabledProperties>
          termsWithQuestionsFilteringEnabled =
          (data['terms-with-questions-levelling-enabled'] as List)
              .map((e) =>
                  TermsWithQuestionsFilteringEnabledProperties.fromJson(e))
              .toList();
      TermsWithQuestionsFilteringEnabledService
          termsWithQuestionsFilteringEnabledService = Get.find();
      await termsWithQuestionsFilteringEnabledService
          .addTermsWithQuestionsFilteringEnabled(
              termsWithQuestionsFilteringEnabled);

      List<TermsParentData> termsParents = (data['terms-parents'] as List)
          .map((e) => TermsParentData.fromJson(e))
          .toList();
      TermsParentService termsParentService = Get.find();
      await termsParentService.addTermsParents(termsParents);

      List<TermLinkedToTagData> termsLinkedToTags =
          (data['terms-linked-to-tags'] as List)
              .map((e) => TermLinkedToTagData.fromJson(e))
              .toList();
      TermLinkedToTagService termLinkedToTagService = Get.find();
      await termLinkedToTagService.addTermsLinkedToTags(termsLinkedToTags);

      List<TermTagData> termsTags = (data['terms-tags'] as List)
          .map((e) => TermTagData.fromJson(e))
          .toList();
      TermTagService termTagService = Get.find();
      await termTagService.addTermTags(termsTags);

      List<TermLinkedToLabelData> termsLinkedToLabels =
          (data['terms-linked-to-labels'] as List)
              .map((e) => TermLinkedToLabelData.fromJson(e))
              .toList();
      TermLinkedToLabelService termLinkedToLabelService = Get.find();
      await termLinkedToLabelService
          .addTermsLinkedToLabels(termsLinkedToLabels);

      List<TermLabelData> termsLabels = (data['terms-labels'] as List)
          .map((e) => TermLabelData.fromJson(e))
          .toList();
      TermLabelService termLabelService = Get.find();
      await termLabelService.addTermLabels(termsLabels);

      termService.subscribeToTermsUpdates(updatedTerms);
    },
            onConnectionFailed: () {},
            onMessageReceived: (FailureResponse message) {})
        .get(url: ApiConstant.getTermsUpdates);
  }

  Future<void> showRequestReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  void recieveNewToken() {
    FirebaseRepository firebaseRepository = Get.find();
    firebaseRepository.onTokenRefresh().listen((event) {
      userService.setToken(event);
      userService.setTokenUploaded(false);
    });
  }

  //TODO apply test
  void configureUserToken() {
    if (userService.getId() == null || userService.getToken() == null) return;
    if (userService.tokenUploaded() == false) {
      NetworkService(context,
              onPreConnect: () {},
              onPostConnect: () {},
              onConnectionSucceed: (body) => userService.setTokenUploaded(true),
              onConnectionFailed: () {},
              onMessageReceived: (FailureResponse message) {})
          .patch(
              url: ApiConstant.updateToken,
              body: {'token': userService.getToken()});
    }
  }

  //TODO add test
  Future<void> subscribeToTopics() async {
    FCMTopicService fcmTopicService = Get.find();
    FirebaseRepository firebaseRepository = Get.find();
    List<FcmTopic> fcmTopics = await fcmTopicService.getFailedTopics();
    for (var element in fcmTopics) {
      firebaseRepository
          .subscribeToTopic(element.title)
          .then((_) => fcmTopicService.addFCMTopic(
              FcmTopic(title: element.title, subscriptionSucceed: true)))
          .onError((error, stackTrace) => fcmTopicService.addFCMTopic(
              FcmTopic(title: element.title, subscriptionSucceed: false)));
    }
  }

  //TODO add test
  void subscribeToAllNotifications() {
    FirebaseRepository firebaseRepository = Get.find();
    UserService userService = Get.find();
    if (!userService.allTopicSubscribed()) {
      firebaseRepository
          .subscribeToTopic("all")
          .then((value) => userService.setAllTopicSubscribed(true));
    }
  }

  Future<void> executePendingRequests() async {
    HttpRequestService httpRequestService = Get.find();
    List<HttpRequest> httpRequests =
        await httpRequestService.getPendingRequests();
    for (HttpRequest httpRequest in httpRequests) {
      NetworkService(
        // ignore: use_build_context_synchronously
        context,
        onPreConnect: () {},
        onPostConnect: () {},
        onConnectionSucceed: (body) =>
            httpRequestService.deletePendingRequest(httpRequest),
        onConnectionFailed: () {},
        onMessageReceived: (FailureResponse message) {},
      ).post(url: httpRequest.url, body: httpRequest.mapp);
    }
  }
}
