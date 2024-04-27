// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:beta/application/services/coupon_linked_to_term_service.dart';
import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/application/services/related_term_service.dart';
import 'package:beta/application/services/term_label_service.dart';
import 'package:beta/application/services/term_linked_to_label_service.dart';
import 'package:beta/application/services/term_linked_to_tag_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/application/services/terms_with_questions_filtering_enabled_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_question.dart';
import 'package:beta/domain/value/layer.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/presentation/choose_term/check_term_widget.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/dialogues/confirm_dialogue.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/widgets/list_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class ChooseTermScreenController extends ListController {
  ChooseTermScreenController(state, {required this.argument})
      : super(
            itemBuilder: (context, index) => CheckTermWidget(
                  index: index,
                ),
            state: state,
            plural: 'terms',
            indexUrl: ApiConstant.termSubTerms
                .replaceFirst('(COUPON_ID)', argument.coupon.id.toString())
                .replaceFirst('(ROOT_TERM_ID)',
                    argument.couponType.rootTermId.value.toString())
                .replaceFirst('(TERM_ID)',
                    argument.couponType.rootTermId.value.toString()),
            remote: argument.terms.isEmpty,
            fetch: () => Future.value(argument.terms),
            showRefresh: false,
            fromJson: TermData.fromJson,
            showLoadMore: false);

  bool okButtonClicked = false;
  Layer layer = const Layer(0);
  List termsListing = [];

  ChooseTermScreenArgument argument;

  List<TermData> checkedTerms = [];
  List<TermQuestion> termQuestions = [];

//TODO add test
  void onOkClicked() {
    if (!argument.free) {
      showConfirmationDialog(state.context, sendData,
          content: const ConfirmationDialogueWidget());
    } else {
      sendData();
    }
  }

  //TODO add tests
  void sendData() => NetworkService(state.context,
          onPreConnect: () => state.setState(() {
                message = '';
                loading = true;
                okButtonClicked = true;
              }),
          onPostConnect: () => state.setState(() {
                message = '';
                loading = false;
                okButtonClicked = false;
              }),
          onConnectionSucceed: (data) async {
            if (data['termQuestions'] != null) {
              List<TermQuestion> termQuestions = (data['termQuestions'] as List)
                  .map((e) => TermQuestion.fromJson(e))
                  .toList();
              var result = await showDialog(
                  context: state.context,
                  builder: (c) => TermQuestionsForm(
                        termQuestions: termQuestions,
                      ));
              if (result is List<TermQuestion>) {
                state.setState(() {
                  this.termQuestions = result as List<TermQuestion>;
                });
                sendData();
              }
              return;
            }

            state.setState(() {
              message = '';
              loading = true;
              okButtonClicked = true;
            });

            CouponService couponService = Get.find();
            await couponService.addCoupon(argument.coupon);

            List<Term> terms = (data['terms'] as List)
                .map((e) => TermData.fromJson(e).term)
                .toList();
            TermService termService = Get.find();
            await termService.addTerms(terms);

            List<RelatedTerm> relatedTerms = (data['related-terms'] as List)
                .map((e) => RelatedTerm.fromJson(e))
                .toList();
            RelatedTermService relatedTermService = Get.find();
            await relatedTermService.addRelatedTerms(relatedTerms);

            List<TermsWithQuestionsFilteringEnabledData>
                termsWithQuestionsFilteringEnabled =
                (data['terms-with-questions-levelling-enabled'] as List)
                    .map((e) =>
                        TermsWithQuestionsFilteringEnabledData.fromJson(e))
                    .toList();
            TermsWithQuestionsFilteringEnabledService
                termsWithQuestionsFilteringEnabledService = Get.find();
            await termsWithQuestionsFilteringEnabledService
                .addTermsWithQuestionsFilteringEnabled(
                    termsWithQuestionsFilteringEnabled);

            List<TermsParent> termsParents = (data['terms-parents'] as List)
                .map((e) => TermsParent.fromJson(e))
                .toList();
            TermsParentService termsParentService = Get.find();
            await termsParentService.addTermsParents(termsParents);

            List<TermsLinkedToTag> termsLinkedToTags =
                (data['terms-linked-to-tags'] as List)
                    .map((e) => TermsLinkedToTag.fromJson(e))
                    .toList();
            TermLinkedToTagService termLinkedToTagService = Get.find();
            await termLinkedToTagService
                .addTermsLinkedToTags(termsLinkedToTags);

            List<TermTag> termsTags = (data['terms-tags'] as List)
                .map((e) => TermTag.fromJson(e))
                .toList();
            TermTagService termTagService = Get.find();
            await termTagService.addTermTags(termsTags);

            List<TermsLinkedToLabel> termsLinkedToLabels =
                (data['terms-linked-to-labels'] as List)
                    .map((e) => TermsLinkedToLabel.fromJson(e))
                    .toList();
            TermLinkedToLabelService termLinkedToLabelService = Get.find();
            await termLinkedToLabelService
                .addTermsLinkedToLabels(termsLinkedToLabels);

            List<TermLabel> termsLabels = (data['terms-labels'] as List)
                .map((e) => TermLabel.fromJson(e))
                .toList();
            TermLabelService termLabelService = Get.find();
            await termLabelService.addTermLabels(termsLabels);

            CouponLinkedToTermService couponLinkedToTermService = Get.find();
            for (Term term in terms) {
              termService.subscribeToTermUpdates(term);
              await couponLinkedToTermService.addCouponLinkedToTerm(
                  CouponsLinkedToTerm(
                      couponId: argument.coupon.id, termId: term.id));
            }
            Navigator.popUntil(
                // ignore: use_build_context_synchronously
                state.context,
                ModalRoute.withName(HomeScreen.route));
          },
          onConnectionFailed: () =>
              state.setState(() => message = StringConstant.noConnection.tr()),
          onMessageReceived: (FailureResponse response) => state.setState(() {
                message = response.content;
              })).post(
          url: ApiConstant.linkCouponWithTerms
              .replaceFirst('(COUPON_ID)', argument.coupon.id.toString()),
          body: {
            'terms': jsonEncode(checkedTerms.map((e) => e.toJson()).toList()),
            'termQuestions': jsonEncode(termQuestions
                .where((element) => element.answer != null)
                .map((e) => {'id': e.id.value, 'answer': e.answer})
                .toList())
          });

  //TODO add test
  bool showCheckBoxes() =>
      argument.terms.isNotEmpty || layer == argument.couponType.layer;

  String _getUrl({TermData? termData}) {
    String url = ApiConstant.termSubTerms
        .replaceFirst('(COUPON_ID)', argument.coupon.id.toString())
        .replaceFirst(
            '(ROOT_TERM_ID)', argument.couponType.rootTermId.value.toString());
    if (layer.value == 0) {
      return url.replaceFirst(
          '(TERM_ID)', argument.couponType.rootTermId.value.toString());
    }
    return url.replaceFirst('(TERM_ID)', termData!.term.id.toString());
  }

  //TODO add test
  void checkTerm(TermData termData, bool? value) {
    if (argument.terms.isNotEmpty) return;
    state.setState(() {
      if (value! &&
          checkedTerms.length < argument.couponType.numberOfObjects.value) {
        checkedTerms.add(termData);
      } else {
        checkedTerms.remove(termData);
      }
    });
  }

  //TODO add test
  Future onTermClick(int index) async {
    TermData termData = items[index];
    if (showCheckBoxes()) {
      checkTerm(termData, !isTermChecked(termData));
      return;
    }
    remote = true;
    indexUrl = _getUrl(termData: termData);
    preItemLoading(index);
    await init(refresh: true);
    // postItemLoading(index);
  }

  //TODO add test
  void setLayer(Layer layer) {
    state.setState(() {
      this.layer = layer;
    });
  }

  //TODO add test
  void initLayer() {
    setLayer(Layer(layer.value + 1));
    // termsListing.add((jsonDecode(jsonEncode(items)) as List)
    //     .map((e) => TermData.fromJson(jsonDecode(e)))
    //     .toList());
    termsListing.add([...items]);
  }

  //TODO add test
  bool isTermChecked(TermData termData) => checkedTerms.contains(termData);

  //TODO add test
  bool canPop() => layer.value < 2;

  //TODO add test
  void onPopInvoked(bool value) {
    if (!value) {
      setLayer(Layer(layer.value - 1));
      termsListing.removeLast();
      remote = false;
      fetch = () => Future.value(termsListing.last);
      checkedTerms.clear();
      init(refresh: true);
    }
  }

  //TODO add test
  bool okButtonVisible() =>
      checkedTerms.length == argument.couponType.numberOfObjects.value;

  @override
  Function()? get onConnectionSucceed => initLayer;

  @override
  Function? get onPreFetch => () {
        if (argument.terms.isNotEmpty) checkedTerms = argument.terms;
      };

  bool displayPath(index) {
    TermData currentTermData = items[index];
    if (currentTermData.path == null) return false;
    if (index == 0) return true;
    TermData previousTermData = items[index - 1];
    return currentTermData.path != previousTermData.path;
  }
}
