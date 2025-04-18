// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deleted_at.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DeletedAt {
  String? get value => throw _privateConstructorUsedError;

  /// Create a copy of DeletedAt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeletedAtCopyWith<DeletedAt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletedAtCopyWith<$Res> {
  factory $DeletedAtCopyWith(DeletedAt value, $Res Function(DeletedAt) then) =
      _$DeletedAtCopyWithImpl<$Res, DeletedAt>;
  @useResult
  $Res call({String? value});
}

/// @nodoc
class _$DeletedAtCopyWithImpl<$Res, $Val extends DeletedAt>
    implements $DeletedAtCopyWith<$Res> {
  _$DeletedAtCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeletedAt
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$DeletedAtImplCopyWith<$Res>
    implements $DeletedAtCopyWith<$Res> {
  factory _$$DeletedAtImplCopyWith(
          _$DeletedAtImpl value, $Res Function(_$DeletedAtImpl) then) =
      __$$DeletedAtImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? value});
}

/// @nodoc
class __$$DeletedAtImplCopyWithImpl<$Res>
    extends _$DeletedAtCopyWithImpl<$Res, _$DeletedAtImpl>
    implements _$$DeletedAtImplCopyWith<$Res> {
  __$$DeletedAtImplCopyWithImpl(
      _$DeletedAtImpl _value, $Res Function(_$DeletedAtImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeletedAt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$DeletedAtImpl(
      freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DeletedAtImpl implements _DeletedAt {
  const _$DeletedAtImpl([this.value]);

  @override
  final String? value;

  @override
  String toString() {
    return 'DeletedAt(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletedAtImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of DeletedAt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletedAtImplCopyWith<_$DeletedAtImpl> get copyWith =>
      __$$DeletedAtImplCopyWithImpl<_$DeletedAtImpl>(this, _$identity);
}

abstract class _DeletedAt implements DeletedAt {
  const factory _DeletedAt([final String? value]) = _$DeletedAtImpl;

  @override
  String? get value;

  /// Create a copy of DeletedAt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeletedAtImplCopyWith<_$DeletedAtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
