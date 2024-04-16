import 'package:beta/application/services/database_service.dart';

class TermData extends terms {
  String? path;
  TermData(
      {required super.id,
      required super.uuid,
      required super.name,
      required super.type,
      required super.creation,
      required super.enabled,
      required super.free,
      required super.ordering,
      required super.needsUpdate,
      required super.captureable,
      required super.textCulumn,
      this.path});

  static TermData fromJson(Map<String, dynamic> json) {
    TermData termData = terms.fromJson(json) as TermData;
    termData.path = json['path'];
    return termData;
  }
}
