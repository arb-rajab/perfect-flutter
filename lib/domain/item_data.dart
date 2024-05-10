import 'package:beta/domain/value/deleted_at.dart';

class ItemData {
  DeletedAt? deletedAt;

  ItemData({this.deletedAt});

  bool isDeleted() => deletedAt!.value != null && deletedAt!.value != '';

  Map toJson() => {'deleted_at': deletedAt?.value};
}
