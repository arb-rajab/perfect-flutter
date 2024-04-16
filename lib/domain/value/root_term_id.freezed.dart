// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'root_term_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RootTermId {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RootTermIdCopyWith<RootTermId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RootTermIdCopyWith<$Res> {
  factory $RootTermIdCopyWith(
          RootTermId value, $Res Function(RootTermId) then) =
      _$RootTermIdCopyWithImpl<$Res, RootTermId>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$RootTermIdCopyWithImpl<$Res, $Val extends RootTermId>
    implements $RootTermIdCopyWith<$Res> {
  _$RootTermIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$RootTermIdImplCopyWith<$Res>
    implements $RootTermIdCopyWith<$Res> {
  factory _$$RootTermIdImplCopyWith(
          _$RootTermIdImpl value, $Res Function(_$RootTermIdImpl) then) =
      __$$RootTermIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$RootTermIdImplCopyWithImpl<$Res>
    extends _$RootTermIdCopyWithImpl<$Res, _$RootTermIdImpl>
    implements _$$RootTermIdImplCopyWith<$Res> {
  __$$RootTermIdImplCopyWithImpl(
      _$RootTermIdImpl _value, $Res Function(_$RootTermIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$RootTermIdImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RootTermIdImpl implements _RootTermId {
  const _$RootTermIdImpl(this.value);

  @override
  final int value;

  @override
  String toString() {
    return 'RootTermId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RootTermIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RootTermIdImplCopyWith<_$RootTermIdImpl> get copyWith =>
      __$$RootTermIdImplCopyWithImpl<_$RootTermIdImpl>(this, _$identity);
}

abstract class _RootTermId implements RootTermId {
  const factory _RootTermId(final int value) = _$RootTermIdImpl;

  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$RootTermIdImplCopyWith<_$RootTermIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
