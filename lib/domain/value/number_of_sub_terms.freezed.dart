// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'number_of_sub_terms.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NumberOfSubTerms {
  int? get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NumberOfSubTermsCopyWith<NumberOfSubTerms> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NumberOfSubTermsCopyWith<$Res> {
  factory $NumberOfSubTermsCopyWith(
          NumberOfSubTerms value, $Res Function(NumberOfSubTerms) then) =
      _$NumberOfSubTermsCopyWithImpl<$Res, NumberOfSubTerms>;
  @useResult
  $Res call({int? value});
}

/// @nodoc
class _$NumberOfSubTermsCopyWithImpl<$Res, $Val extends NumberOfSubTerms>
    implements $NumberOfSubTermsCopyWith<$Res> {
  _$NumberOfSubTermsCopyWithImpl(this._value, this._then);

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
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NumberOfSubTermsImplCopyWith<$Res>
    implements $NumberOfSubTermsCopyWith<$Res> {
  factory _$$NumberOfSubTermsImplCopyWith(_$NumberOfSubTermsImpl value,
          $Res Function(_$NumberOfSubTermsImpl) then) =
      __$$NumberOfSubTermsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? value});
}

/// @nodoc
class __$$NumberOfSubTermsImplCopyWithImpl<$Res>
    extends _$NumberOfSubTermsCopyWithImpl<$Res, _$NumberOfSubTermsImpl>
    implements _$$NumberOfSubTermsImplCopyWith<$Res> {
  __$$NumberOfSubTermsImplCopyWithImpl(_$NumberOfSubTermsImpl _value,
      $Res Function(_$NumberOfSubTermsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$NumberOfSubTermsImpl(
      freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$NumberOfSubTermsImpl implements _NumberOfSubTerms {
  const _$NumberOfSubTermsImpl(this.value)
      : assert(value == null || value >= 0);

  @override
  final int? value;

  @override
  String toString() {
    return 'NumberOfSubTerms(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NumberOfSubTermsImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NumberOfSubTermsImplCopyWith<_$NumberOfSubTermsImpl> get copyWith =>
      __$$NumberOfSubTermsImplCopyWithImpl<_$NumberOfSubTermsImpl>(
          this, _$identity);
}

abstract class _NumberOfSubTerms implements NumberOfSubTerms {
  const factory _NumberOfSubTerms(final int? value) = _$NumberOfSubTermsImpl;

  @override
  int? get value;
  @override
  @JsonKey(ignore: true)
  _$$NumberOfSubTermsImplCopyWith<_$NumberOfSubTermsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
