import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:get/instance_manager.dart';

class AnswerData {
  Answer answer;
  late List<AnswerProperty> answerProperties;

  AnswerService answerService = Get.find();
  AnswerPropertyService answerPropertyService = Get.find();

  AnswerData(this.answer) {
    _configureProperties();
  }

  _configureProperties() async => answerProperties =
      await answerPropertyService.getAnswerProperties(answer.id);

  bool isChecked() {
    for (AnswerProperty answerProperty in answerProperties) {
      if (answerProperty.name == 'checked') {
        return answerProperty.value == 'true';
      }
    }
    return false;
  }

  Future setChecked(bool value) async {
    if (value) {
      await answerPropertyService.checkAnswer(answer.id);
    } else {
      await answerPropertyService.uncheckAnswer(answer.id);
    }
    return answerPropertyService
        .getAnswerProperties(answer.id)
        .then((value) => answerProperties = value);
  }

  String getTranslatableTitle(bool translated) {
    if (translated && answer.titleTranslation.isNotEmpty) {
      return answer.titleTranslation;
    }
    return answer.title;
  }
}
