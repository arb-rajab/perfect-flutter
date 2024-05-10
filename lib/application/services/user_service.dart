import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';

class UserService {
  final KeyValue keyValue;
  UserService({required this.keyValue});
  //TODO add test
  Future setId(int id) =>
      keyValue.setString(KeyValueConstant.userId, id.toString());

  //TODO add test
  Future setToken(String token) =>
      keyValue.setString(KeyValueConstant.userId, token);

  //TODO add test
  String? getId() => keyValue.getString(KeyValueConstant.userId);

  //TODO add test
  String? getToken() => keyValue.getString(KeyValueConstant.userToken);

  //TODO add test
  bool tokenUploaded() =>
      keyValue.getBool(KeyValueConstant.tokenUploaded, false)!;

  //TODO add test
  Future setTokenUploaded(bool value) =>
      keyValue.setBool(KeyValueConstant.tokenUploaded, value);

  //TODO add test
  bool allTopicSubscribed() =>
      keyValue.getBool(KeyValueConstant.isAllTokenSubscribed, false)!;

  //TODO add test
  Future setAllTopicSubscribed(bool value) =>
      keyValue.setBool(KeyValueConstant.isAllTokenSubscribed, value);
}
