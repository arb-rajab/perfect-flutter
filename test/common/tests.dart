import 'package:beta/application/services/network_service.dart';
import 'package:beta/main_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

late DioAdapter dioAdapter;

Future initTests() async {
  MainController.testing = true;
  TestWidgetsFlutterBinding.ensureInitialized();
  await MainController.initServices();
  dioAdapter = DioAdapter(dio: NetworkService.dio);
  EasyLocalization.logger.enableLevels = [];
}
