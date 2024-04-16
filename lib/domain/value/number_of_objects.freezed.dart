// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'number_of_objects.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NumberOfObjects {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NumberOfObjectsCopyWith<NumberOfObjects> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NumberOfObjectsCopyWith<$Res> {
  factory $NumberOfObjectsCopyWith(
          NumberOfObjects value, $Res Function(NumberOfObjects) then) =
      _$NumberOfObjectsCopyWithImpl<$Res, NumberOfObjects>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$NumberOfObjectsCopyWithImpl<$Res, $Val extends NumberOfObjects>
    implements $NumberOfObjectsCopyWith<$Res> {
  _$NumberOfObjectsCopyWithImpl(this._value, this._then);

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
abstract class _$$NumberOfObjectsImplCopyWith<$Res>
    implements $NumberOfObjectsCopyWith<$Res> {
  factory _$$NumberOfObjectsImplCopyWith(_$NumberOfObjectsImpl value,
          $Res Function(_$NumberOfObjectsImpl) then) =
      __$$NumberOfObjectsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$NumberOfObjectsImplCopyWithImpl<$Res>
    extends _$NumberOfObjectsCopyWithImpl<$Res, _$NumberOfObjectsImpl>
    implements _$$NumberOfObjectsImplCopyWith<$Res> {
  __$$NumberOfObjectsImplCopyWithImpl(
      _$NumberOfObjectsImpl _value, $Res Function(_$NumberOfObjectsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$NumberOfObjectsImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$NumberOfObjectsImpl implements _NumberOfObjects {
  const _$NumberOfObjectsImpl(this.value) : assert(value >= 1);

  @override
  final int value;

  @override
  String toString() {
    return 'NumberOfObjects(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NumberOfObjectsImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NumberOfObjectsImplCopyWith<_$NumberOfObjectsImpl> get copyWith =>
      __$$NumberOfObjectsImplCopyWithImpl<_$NumberOfObjectsImpl>(
          this, _$identity);
}

abstract class _NumberOfObjects implements NumberOfObjects {
  const factory _NumberOfObjects(final int value) = _$NumberOfObjectsImpl;

  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$NumberOfObjectsImplCopyWith<_$NumberOfObjectsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
