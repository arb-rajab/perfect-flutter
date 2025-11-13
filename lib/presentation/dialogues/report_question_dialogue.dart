import 'package:beta/application/services/network_service.dart';
import 'package:beta/common/validators.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/dialogues/success_dialogue.dart';
import 'package:beta/presentation/questions/question_title.dart';
import 'package:beta/presentation/widgets/input_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showReportQuestionDialogue(
    BuildContext context, QuestionData questionData) async {
  // Show dialog returns a Future that completes when the dialog is dismissed.
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => ReportQuestionDialogue(questionData),
  );
}

class ReportQuestionDialogue extends StatefulWidget {
  final QuestionData questionData;
  const ReportQuestionDialogue(this.questionData, {super.key});

  @override
  State<ReportQuestionDialogue> createState() => _ReportQuestionDialogueState();
}

class _ReportQuestionDialogueState extends State<ReportQuestionDialogue> {
  bool loading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String message = '';
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
        child: AlertDialog(
            title: ListTile(
              leading: const Icon(Icons.warning),
              title: Text(StringConstant.reportQuestionNumber.tr().replaceAll(
                  '(NUMBER)',
                  (widget.questionData.indexInTerm + 1).toString())),
            ),
            actions: <Widget>[
              TextButton(
                  child: ListTile(
                    title: Text(StringConstant.send.tr()),
                    leading: loading
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.send),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      NetworkService(
                          onPreConnect: () => setState(() {
                                loading = true;
                                message = '';
                              }),
                          onPostConnect: () => setState(() {
                                loading = false;
                                message = '';
                              }),
                          onConnectionSucceed: (dynamic data) {
                            context.pop();
                            showSuccessDialogue(context);
                            return Future.value();
                          },
                          onConnectionFailed: () => setState(() {
                                message = StringConstant.noConnection.tr();
                              }),
                          onMessageReceived: (FailureResponse response) =>
                              setState(() {
                                message = response.content;
                              })).post(
                          url: ApiConstant.reportQuestion.replaceFirst(
                              '(QUESTION_ID)',
                              widget.questionData.question.id.toString()),
                          body: {'suggestion': textEditingController.text});
                    }
                  })
            ],
            content: SingleChildScrollView(
                child: Column(
              children: [
                if (message.isNotEmpty) Text(message),
                ListTile(
                  title: Text(StringConstant.questionTitle.tr()),
                  subtitle: QuestionTitle(
                    questionData: widget.questionData,
                  ),
                ),
                Form(
                  key: formKey,
                  child: InputWidget(
                    label: StringConstant.enterSuggestion.tr(),
                    controller: textEditingController,
                    maxLines: 3,
                    validator: Validator.empty,
                  ),
                )
              ],
            ))));
  }
}
