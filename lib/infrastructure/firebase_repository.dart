import 'package:beta/firebase_options.dart';
import 'package:beta/main_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseRepository {
  Future subscribeToTopic(String topic) {
    if (MainController.testing) return Future.value();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    return firebaseMessaging.subscribeToTopic(topic);
  }

  Future initialise() async {
    if (!MainController.testing) {
      await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    }
    return Future.value(this);
  }
}
