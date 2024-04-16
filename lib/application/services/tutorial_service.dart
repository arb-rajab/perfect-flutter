import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';

class TutorialService {
  final KeyValue keyValue;
  TutorialService({required this.keyValue});

  bool isTutorialDismissed(String tutorial) {
    List<String>? dismissedTutorials =
        keyValue.getStringList(KeyValueConstant.dismissedTutorials);
    if (dismissedTutorials == null) return false;
    return dismissedTutorials.contains(tutorial);
  }

  Future dismissTutorial(String tutorial) {
    List<String>? dismissedTutorials =
        keyValue.getStringList(KeyValueConstant.dismissedTutorials);
    dismissedTutorials ??= [];
    if (!isTutorialDismissed(tutorial)) dismissedTutorials.add(tutorial);
    return keyValue.setStringList(
        KeyValueConstant.dismissedTutorials, dismissedTutorials);
  }
}
