import 'package:beta/constants/api_constant.dart';
import 'package:beta/domain/frequent_question.dart';
import 'package:beta/presentation/frequent_questions/frequent_question_widget.dart';
import 'package:beta/presentation/widgets/list_controller.dart';

class FrequestQuestionsScreenController
    extends ListController<FrequentQuestion> {
  FrequestQuestionsScreenController(state)
      : super(
            itemBuilder: (context, index) =>
                FrequentQuestionWidget(index: index),
            state: state,
            plural: 'frequent-questions',
            fetch: null,
            fromJson: FrequentQuestion.fromJson,
            indexUrl: ApiConstant.frequentQuestions);
}
