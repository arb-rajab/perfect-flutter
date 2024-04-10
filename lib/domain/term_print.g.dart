// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_print.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermPrint _$TermPrintFromJson(Map<String, dynamic> json) => TermPrint(
      gift: const GiftTypeJsonConverter().fromJson(json['gift'] as int),
      otherGift:
          const OtherGiftJsonConverter().fromJson(json['otherGift'] as String?),
    );

Map<String, dynamic> _$TermPrintToJson(TermPrint instance) => <String, dynamic>{
      'gift': const GiftTypeJsonConverter().toJson(instance.gift),
      'otherGift': const OtherGiftJsonConverter().toJson(instance.otherGift),
    };
