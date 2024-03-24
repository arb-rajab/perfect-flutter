import 'package:beta/common/boolean_converter.dart';
import 'package:beta/common/date_time_converter.dart';
import 'package:beta/domain/value/data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/text.dart';
import 'package:beta/domain/value/title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
@JsonSerializable()
class Notification with _$Notification {
  factory Notification(
      {@IdJsonConverter() required Id id,
      @TitleJsonConverter() required Title title,
      @TextJsonConverter() required Text text,
      @DataJsonConverter() required Data data,
      @BooleanConverter() required bool? seen,
      @DateTimeConverter() required DateTime creation}) = _Notification;

  static Notification fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}
