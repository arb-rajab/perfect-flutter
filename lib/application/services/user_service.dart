import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';

class UserService {
  final KeyValue keyValue;
  UserService({required this.keyValue});
  Future setId(int id) =>
      keyValue.setString(KeyValueConstant.userId, id.toString());
}
