// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GiftType {
  int get value => throw _privateConstructorUsedError;

  /// Create a copy of GiftType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftTypeCopyWith<GiftType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftTypeCopyWith<$Res> {
  factory $GiftTypeCopyWith(GiftType value, $Res Function(GiftType) then) =
      _$GiftTypeCopyWithImpl<$Res, GiftType>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$GiftTypeCopyWithImpl<$Res, $Val extends GiftType>
    implements $GiftTypeCopyWith<$Res> {
  _$GiftTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GiftTypeImplCopyWith<$Res>
    implements $GiftTypeCopyWith<$Res> {
  factory _$$GiftTypeImplCopyWith(
          _$GiftTypeImpl value, $Res Function(_$GiftTypeImpl) then) =
      __$$GiftTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$GiftTypeImplCopyWithImpl<$Res>
    extends _$GiftTypeCopyWithImpl<$Res, _$GiftTypeImpl>
    implements _$$GiftTypeImplCopyWith<$Res> {
  __$$GiftTypeImplCopyWithImpl(
      _$GiftTypeImpl _value, $Res Function(_$GiftTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$GiftTypeImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GiftTypeImpl implements _GiftType {
  const _$GiftTypeImpl(this.value) : assert(value >= 0 && value <= 2);

  @override
  final int value;

  @override
  String toString() {
    return 'GiftType(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftTypeImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of GiftType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftTypeImplCopyWith<_$GiftTypeImpl> get copyWith =>
      __$$GiftTypeImplCopyWithImpl<_$GiftTypeImpl>(this, _$identity);
}

abstract class _GiftType implements GiftType {
  const factory _GiftType(final int value) = _$GiftTypeImpl;

  @override
  int get value;

  /// Create a copy of GiftType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftTypeImplCopyWith<_$GiftTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
