import 'package:beta/application/services/database_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/coupon_type.dart';
import 'package:beta/domain/multi_select_selection.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/term_question.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/choose_term/choose_term_screen_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:beta/presentation/widgets/widget_wrapper_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class ChooseTermScreen extends StatefulWidget {
  static const String route = '/choose-term';
  const ChooseTermScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChooseTermScreenState();
}

class _ChooseTermScreenState extends State<ChooseTermScreen> {
  late ChooseTermScreenController _controller;

  @override
  void dispose() {
    Get.delete<ChooseTermScreenController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as dynamic;
    if (!Get.isRegistered<ChooseTermScreenController>()) {
      _controller = Get.put(ChooseTermScreenController(this, argument: args));
    }
    return PopScope(
      canPop: _controller.canPop(),
      onPopInvoked: _controller.onPopInvoked,
      child: ScreenWrapper(
          child: Column(
        children: [
          Expanded(
            child: ItemsList(controller: _controller),
          ),
          if (_controller.okButtonVisible())
            SubmitButton(
                text: StringConstant.ok.tr(),
                onSubmit: _controller.onOkClicked,
                loading: _controller.loading && _controller.okButtonClicked)
        ],
      )),
    );
  }
}

class ChooseTermScreenArgument {
  final Coupon coupon;
  final List<TermData> terms;
  final bool free;
  final CouponType couponType;

  ChooseTermScreenArgument(
      {required this.coupon,
      required this.terms,
      required this.free,
      required this.couponType});
}

//TODO add tests
class ConfirmationDialogueWidget extends StatelessWidget {
  const ConfirmationDialogueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ChooseTermScreenController controller = Get.find();
    return Column(
      children: [
        Text(StringConstant.aboutToCouponWithTerms.tr()),
        for (int c = 0; c < controller.checkedTerms.length; c++)
          Row(
            children: [
              Text(controller.checkedTerms[c].path!.value!),
              Text(
                controller.checkedTerms[c].term.name,
                style: TextStyle(color: Theme.of(context).primaryColor),
              )
            ],
          ),
        Text(StringConstant.doYouWantToProceed.tr())
      ],
    );
  }
}

//TODO add test
class TermQuestionsForm extends StatefulWidget {
  final List<TermQuestion> termQuestions;
  const TermQuestionsForm({super.key, required this.termQuestions});

  @override
  State<TermQuestionsForm> createState() => _TermQuestionsFormState();
}

class _TermQuestionsFormState extends State<TermQuestionsForm> {
  late List<TermQuestion> termQuestions;
  @override
  void initState() {
    termQuestions = widget.termQuestions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> termQuestionsWidgets = [];
    for (int c = 0; c < termQuestions.length; c++) {
      TermQuestion termQuestion = termQuestions[c];
      switch (termQuestion.type) {
        case TermQuestionType.multiSelection:
          termQuestionsWidgets.add(DropDownButton(
              label: termQuestion.title.value!,
              selectionId: termQuestion.answer != null
                  ? int.parse(termQuestion.answer!)
                  : termQuestion.multiSelections[0].id.value,
              selections: termQuestion.multiSelections.toList(),
              onChanged: (value) {
                setState(() {
                  termQuestion =
                      termQuestion.copyWith(answer: value.toString());
                  termQuestions[c] = termQuestion;
                });
              }));
          break;
      }
    }
    return OpacityAnimation(
        child: AlertDialog(
      title: Text(StringConstant.pleaseFillTheQuestionary.tr()),
      content: ListView(children: termQuestionsWidgets),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, termQuestions),
            child: Text(StringConstant.ok.tr()))
      ],
    ));
  }
}

//TODO add test
class DropDownButton extends StatelessWidget {
  final String label;
  final int selectionId;
  final List<MultiSelectSelection> selections;
  final Function(dynamic) onChanged;
  const DropDownButton(
      {super.key,
      required this.label,
      required this.selectionId,
      required this.selections,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          WidgetWrapperWithBorder(
              child: DropdownButton(
            value: selectionId,
            items: selections
                .map((e) => DropdownMenuItem(
                    value: e.id.value, child: Text(e.title.value!)))
                .toList(),
            onChanged: onChanged,
          )),
          const SizedBox(
            height: 30,
          ),
        ]);
  }
}
