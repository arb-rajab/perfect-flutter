// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_gift.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OtherGift {
  String? get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OtherGiftCopyWith<OtherGift> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtherGiftCopyWith<$Res> {
  factory $OtherGiftCopyWith(OtherGift value, $Res Function(OtherGift) then) =
      _$OtherGiftCopyWithImpl<$Res, OtherGift>;
  @useResult
  $Res call({String? value});
}

/// @nodoc
class _$OtherGiftCopyWithImpl<$Res, $Val extends OtherGift>
    implements $OtherGiftCopyWith<$Res> {
  _$OtherGiftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtherGiftImplCopyWith<$Res>
    implements $OtherGiftCopyWith<$Res> {
  factory _$$OtherGiftImplCopyWith(
          _$OtherGiftImpl value, $Res Function(_$OtherGiftImpl) then) =
      __$$OtherGiftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? value});
}

/// @nodoc
class __$$OtherGiftImplCopyWithImpl<$Res>
    extends _$OtherGiftCopyWithImpl<$Res, _$OtherGiftImpl>
    implements _$$OtherGiftImplCopyWith<$Res> {
  __$$OtherGiftImplCopyWithImpl(
      _$OtherGiftImpl _value, $Res Function(_$OtherGiftImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$OtherGiftImpl(
      freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$OtherGiftImpl implements _OtherGift {
  const _$OtherGiftImpl([this.value]);

  @override
  final String? value;

  @override
  String toString() {
    return 'OtherGift(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtherGiftImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherGiftImplCopyWith<_$OtherGiftImpl> get copyWith =>
      __$$OtherGiftImplCopyWithImpl<_$OtherGiftImpl>(this, _$identity);
}

abstract class _OtherGift implements OtherGift {
  const factory _OtherGift([final String? value]) = _$OtherGiftImpl;

  @override
  String? get value;
  @override
  @JsonKey(ignore: true)
  _$$OtherGiftImplCopyWith<_$OtherGiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
