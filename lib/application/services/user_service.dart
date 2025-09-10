import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';

class UserService {
  final KeyValue keyValue;
  UserService({required this.keyValue});
  
  Future setId(int id) =>
      keyValue.setString(KeyValueConstant.userId, id.toString());

  String? getId() => keyValue.getString(KeyValueConstant.userId);

  bool tokenUploaded() =>
      keyValue.getBool(KeyValueConstant.tokenUploaded, false)!;

  Future setTokenUploaded(bool value) =>
      keyValue.setBool(KeyValueConstant.tokenUploaded, value);

  bool allTopicSubscribed() =>
      keyValue.getBool(KeyValueConstant.isAllTokenSubscribed, false)!;

  Future setAllTopicSubscribed(bool value) =>
      keyValue.setBool(KeyValueConstant.isAllTokenSubscribed, value);
}
