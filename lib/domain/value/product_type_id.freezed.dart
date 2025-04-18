// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_type_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductTypeId {
  int get value => throw _privateConstructorUsedError;

  /// Create a copy of ProductTypeId
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductTypeIdCopyWith<ProductTypeId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductTypeIdCopyWith<$Res> {
  factory $ProductTypeIdCopyWith(
          ProductTypeId value, $Res Function(ProductTypeId) then) =
      _$ProductTypeIdCopyWithImpl<$Res, ProductTypeId>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$ProductTypeIdCopyWithImpl<$Res, $Val extends ProductTypeId>
    implements $ProductTypeIdCopyWith<$Res> {
  _$ProductTypeIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductTypeId
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
abstract class _$$ProductTypeIdImplCopyWith<$Res>
    implements $ProductTypeIdCopyWith<$Res> {
  factory _$$ProductTypeIdImplCopyWith(
          _$ProductTypeIdImpl value, $Res Function(_$ProductTypeIdImpl) then) =
      __$$ProductTypeIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$ProductTypeIdImplCopyWithImpl<$Res>
    extends _$ProductTypeIdCopyWithImpl<$Res, _$ProductTypeIdImpl>
    implements _$$ProductTypeIdImplCopyWith<$Res> {
  __$$ProductTypeIdImplCopyWithImpl(
      _$ProductTypeIdImpl _value, $Res Function(_$ProductTypeIdImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductTypeId
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$ProductTypeIdImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ProductTypeIdImpl implements _ProductTypeId {
  const _$ProductTypeIdImpl(this.value) : assert(value >= 0);

  @override
  final int value;

  @override
  String toString() {
    return 'ProductTypeId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductTypeIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of ProductTypeId
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductTypeIdImplCopyWith<_$ProductTypeIdImpl> get copyWith =>
      __$$ProductTypeIdImplCopyWithImpl<_$ProductTypeIdImpl>(this, _$identity);
}

abstract class _ProductTypeId implements ProductTypeId {
  const factory _ProductTypeId(final int value) = _$ProductTypeIdImpl;

  @override
  int get value;

  /// Create a copy of ProductTypeId
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductTypeIdImplCopyWith<_$ProductTypeIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
