import 'package:beta/domain/admin.dart';
import 'package:beta/domain/device.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/number_of_sub_terms.dart';
import 'package:beta/domain/value/text.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
@JsonSerializable()
class Comment with _$Comment {
  factory Comment(
      {@IdJsonConverter() required Id id,
      @TextJsonConverter() required Text content,
      @DeviceJsonConverter() Device? device,
      @AdminJsonConverter() Admin? admin,
      @NumberOfSubTermsJsonConverter()
      required NumberOfSubTerms numberOfComments}) = _Comment;

  static Comment fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  static Map<String, dynamic> toJson(Comment instance) =>
      _$CommentToJson(instance);
}
