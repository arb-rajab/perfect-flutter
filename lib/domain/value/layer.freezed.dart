// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Layer {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LayerCopyWith<Layer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LayerCopyWith<$Res> {
  factory $LayerCopyWith(Layer value, $Res Function(Layer) then) =
      _$LayerCopyWithImpl<$Res, Layer>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$LayerCopyWithImpl<$Res, $Val extends Layer>
    implements $LayerCopyWith<$Res> {
  _$LayerCopyWithImpl(this._value, this._then);

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
abstract class _$$LayerImplCopyWith<$Res> implements $LayerCopyWith<$Res> {
  factory _$$LayerImplCopyWith(
          _$LayerImpl value, $Res Function(_$LayerImpl) then) =
      __$$LayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$LayerImplCopyWithImpl<$Res>
    extends _$LayerCopyWithImpl<$Res, _$LayerImpl>
    implements _$$LayerImplCopyWith<$Res> {
  __$$LayerImplCopyWithImpl(
      _$LayerImpl _value, $Res Function(_$LayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$LayerImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LayerImpl implements _Layer {
  const _$LayerImpl(this.value) : assert(value >= 0);

  @override
  final int value;

  @override
  String toString() {
    return 'Layer(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayerImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LayerImplCopyWith<_$LayerImpl> get copyWith =>
      __$$LayerImplCopyWithImpl<_$LayerImpl>(this, _$identity);
}

abstract class _Layer implements Layer {
  const factory _Layer(final int value) = _$LayerImpl;

  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$LayerImplCopyWith<_$LayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
