// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_print.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TermPrint _$TermPrintFromJson(Map<String, dynamic> json) => _TermPrint(
  gift: const GiftTypeJsonConverter().fromJson((json['gift'] as num).toInt()),
  otherGift: const OtherGiftJsonConverter().fromJson(
    json['otherGift'] as String?,
  ),
);

Map<String, dynamic> _$TermPrintToJson(_TermPrint instance) =>
    <String, dynamic>{
      'gift': const GiftTypeJsonConverter().toJson(instance.gift),
      'otherGift': const OtherGiftJsonConverter().toJson(instance.otherGift),
    };
