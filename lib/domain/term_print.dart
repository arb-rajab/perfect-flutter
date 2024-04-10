import 'package:beta/domain/value/gift_type.dart';
import 'package:beta/domain/value/other_gift.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_print.freezed.dart';
part 'term_print.g.dart';

@freezed
@JsonSerializable()
class TermPrint with _$TermPrint {
  factory TermPrint(
      {@GiftTypeJsonConverter() required GiftType gift,
      @OtherGiftJsonConverter() required OtherGift otherGift}) = _TermPrint;

  static TermPrint fromJson(Map<String, dynamic> json) =>
      _$TermPrintFromJson(json);
}
