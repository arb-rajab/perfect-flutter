// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_print.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TermPrint {
  @GiftTypeJsonConverter()
  GiftType get gift => throw _privateConstructorUsedError;
  @OtherGiftJsonConverter()
  OtherGift get otherGift => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TermPrintCopyWith<TermPrint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermPrintCopyWith<$Res> {
  factory $TermPrintCopyWith(TermPrint value, $Res Function(TermPrint) then) =
      _$TermPrintCopyWithImpl<$Res, TermPrint>;
  @useResult
  $Res call(
      {@GiftTypeJsonConverter() GiftType gift,
      @OtherGiftJsonConverter() OtherGift otherGift});

  $GiftTypeCopyWith<$Res> get gift;
  $OtherGiftCopyWith<$Res> get otherGift;
}

/// @nodoc
class _$TermPrintCopyWithImpl<$Res, $Val extends TermPrint>
    implements $TermPrintCopyWith<$Res> {
  _$TermPrintCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gift = null,
    Object? otherGift = null,
  }) {
    return _then(_value.copyWith(
      gift: null == gift
          ? _value.gift
          : gift // ignore: cast_nullable_to_non_nullable
              as GiftType,
      otherGift: null == otherGift
          ? _value.otherGift
          : otherGift // ignore: cast_nullable_to_non_nullable
              as OtherGift,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GiftTypeCopyWith<$Res> get gift {
    return $GiftTypeCopyWith<$Res>(_value.gift, (value) {
      return _then(_value.copyWith(gift: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OtherGiftCopyWith<$Res> get otherGift {
    return $OtherGiftCopyWith<$Res>(_value.otherGift, (value) {
      return _then(_value.copyWith(otherGift: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TermPrintImplCopyWith<$Res>
    implements $TermPrintCopyWith<$Res> {
  factory _$$TermPrintImplCopyWith(
          _$TermPrintImpl value, $Res Function(_$TermPrintImpl) then) =
      __$$TermPrintImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@GiftTypeJsonConverter() GiftType gift,
      @OtherGiftJsonConverter() OtherGift otherGift});

  @override
  $GiftTypeCopyWith<$Res> get gift;
  @override
  $OtherGiftCopyWith<$Res> get otherGift;
}

/// @nodoc
class __$$TermPrintImplCopyWithImpl<$Res>
    extends _$TermPrintCopyWithImpl<$Res, _$TermPrintImpl>
    implements _$$TermPrintImplCopyWith<$Res> {
  __$$TermPrintImplCopyWithImpl(
      _$TermPrintImpl _value, $Res Function(_$TermPrintImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gift = null,
    Object? otherGift = null,
  }) {
    return _then(_$TermPrintImpl(
      gift: null == gift
          ? _value.gift
          : gift // ignore: cast_nullable_to_non_nullable
              as GiftType,
      otherGift: null == otherGift
          ? _value.otherGift
          : otherGift // ignore: cast_nullable_to_non_nullable
              as OtherGift,
    ));
  }
}

/// @nodoc

class _$TermPrintImpl implements _TermPrint {
  _$TermPrintImpl(
      {@GiftTypeJsonConverter() required this.gift,
      @OtherGiftJsonConverter() required this.otherGift});

  @override
  @GiftTypeJsonConverter()
  final GiftType gift;
  @override
  @OtherGiftJsonConverter()
  final OtherGift otherGift;

  @override
  String toString() {
    return 'TermPrint(gift: $gift, otherGift: $otherGift)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermPrintImpl &&
            (identical(other.gift, gift) || other.gift == gift) &&
            (identical(other.otherGift, otherGift) ||
                other.otherGift == otherGift));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gift, otherGift);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TermPrintImplCopyWith<_$TermPrintImpl> get copyWith =>
      __$$TermPrintImplCopyWithImpl<_$TermPrintImpl>(this, _$identity);
}

abstract class _TermPrint implements TermPrint {
  factory _TermPrint(
          {@GiftTypeJsonConverter() required final GiftType gift,
          @OtherGiftJsonConverter() required final OtherGift otherGift}) =
      _$TermPrintImpl;

  @override
  @GiftTypeJsonConverter()
  GiftType get gift;
  @override
  @OtherGiftJsonConverter()
  OtherGift get otherGift;
  @override
  @JsonKey(ignore: true)
  _$$TermPrintImplCopyWith<_$TermPrintImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
