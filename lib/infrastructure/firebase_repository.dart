import 'package:beta/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseRepository {
  Future subscribeToTopic(String topic) {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    return firebaseMessaging.subscribeToTopic(topic);
  }

  Future initialise() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return Future.value(this);
  }
}
