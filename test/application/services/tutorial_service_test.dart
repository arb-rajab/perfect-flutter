import 'package:beta/application/services/tutorial_service.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:test/test.dart';

Future<void> main() async {
  late TutorialService tutorialService;
  MainController.testing = true;
  KeyValue keyValue = await KeyValue().initialise();
  setUp(() async {
    tutorialService = TutorialService(keyValue: keyValue);
  });

  test('isTutorialDismissed returns false if tutorial not dismissed', () {
    String randomTutorial = 'random';
    expect(tutorialService.isTutorialDismissed(randomTutorial), false);
  });

  test('isTutorialDismissed returns true if tutorial id dismissed', () async {
    String randomTutorial = 'random';
    await keyValue
        .setStringList(KeyValueConstant.dismissedTutorials, [randomTutorial]);
    expect(tutorialService.isTutorialDismissed(randomTutorial), true);
  });

  test('dismiss tutorial dismisses tutorial', () async {
    String randomTutorial = 'random';
    await keyValue.setStringList(KeyValueConstant.dismissedTutorials, []);
    await tutorialService.dismissTutorial(randomTutorial);
    expect(
        keyValue
            .getStringList(KeyValueConstant.dismissedTutorials)
            ?.contains(randomTutorial),
        true);
  });
}
