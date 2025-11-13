import 'package:beta/common/date_time_converter.dart';
import 'package:beta/domain/value/description.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news.freezed.dart';
part 'news.g.dart';

@freezed
@JsonSerializable()
class News with _$News {
  factory News(
      {@IdJsonConverter() required Id id,
      @TitleJsonConverter() required Title title,
      @DescriptionJsonConverter() required Description content,
      // ignore: invalid_annotation_target
      @JsonKey(name: 'created_at')
      @DateTimeConverter()
      required DateTime createdAt}) = _News;

  static News fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  static Map<String, dynamic> toJson(News instance) => _$NewsToJson(instance);
}
