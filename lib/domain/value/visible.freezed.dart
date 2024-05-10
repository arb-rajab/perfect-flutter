// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visible.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Visible {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VisibleCopyWith<Visible> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisibleCopyWith<$Res> {
  factory $VisibleCopyWith(Visible value, $Res Function(Visible) then) =
      _$VisibleCopyWithImpl<$Res, Visible>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$VisibleCopyWithImpl<$Res, $Val extends Visible>
    implements $VisibleCopyWith<$Res> {
  _$VisibleCopyWithImpl(this._value, this._then);

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
abstract class _$$VisibleImplCopyWith<$Res> implements $VisibleCopyWith<$Res> {
  factory _$$VisibleImplCopyWith(
          _$VisibleImpl value, $Res Function(_$VisibleImpl) then) =
      __$$VisibleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$VisibleImplCopyWithImpl<$Res>
    extends _$VisibleCopyWithImpl<$Res, _$VisibleImpl>
    implements _$$VisibleImplCopyWith<$Res> {
  __$$VisibleImplCopyWithImpl(
      _$VisibleImpl _value, $Res Function(_$VisibleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$VisibleImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$VisibleImpl implements _Visible {
  const _$VisibleImpl(this.value) : assert(value == 0 || value == 1);

  @override
  final int value;

  @override
  String toString() {
    return 'Visible(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisibleImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisibleImplCopyWith<_$VisibleImpl> get copyWith =>
      __$$VisibleImplCopyWithImpl<_$VisibleImpl>(this, _$identity);
}

abstract class _Visible implements Visible {
  const factory _Visible(final int value) = _$VisibleImpl;

  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$VisibleImplCopyWith<_$VisibleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
