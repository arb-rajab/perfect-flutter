// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multi_select_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MultiSelectSelection {
  @IdJsonConverter()
  Id get id => throw _privateConstructorUsedError;
  @TitleJsonConverter()
  Title get title => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MultiSelectSelectionCopyWith<MultiSelectSelection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiSelectSelectionCopyWith<$Res> {
  factory $MultiSelectSelectionCopyWith(MultiSelectSelection value,
          $Res Function(MultiSelectSelection) then) =
      _$MultiSelectSelectionCopyWithImpl<$Res, MultiSelectSelection>;
  @useResult
  $Res call({@IdJsonConverter() Id id, @TitleJsonConverter() Title title});

  $IdCopyWith<$Res> get id;
  $TitleCopyWith<$Res> get title;
}

/// @nodoc
class _$MultiSelectSelectionCopyWithImpl<$Res,
        $Val extends MultiSelectSelection>
    implements $MultiSelectSelectionCopyWith<$Res> {
  _$MultiSelectSelectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Id,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Title,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IdCopyWith<$Res> get id {
    return $IdCopyWith<$Res>(_value.id, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TitleCopyWith<$Res> get title {
    return $TitleCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MultiSelectSelectionImplCopyWith<$Res>
    implements $MultiSelectSelectionCopyWith<$Res> {
  factory _$$MultiSelectSelectionImplCopyWith(_$MultiSelectSelectionImpl value,
          $Res Function(_$MultiSelectSelectionImpl) then) =
      __$$MultiSelectSelectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@IdJsonConverter() Id id, @TitleJsonConverter() Title title});

  @override
  $IdCopyWith<$Res> get id;
  @override
  $TitleCopyWith<$Res> get title;
}

/// @nodoc
class __$$MultiSelectSelectionImplCopyWithImpl<$Res>
    extends _$MultiSelectSelectionCopyWithImpl<$Res, _$MultiSelectSelectionImpl>
    implements _$$MultiSelectSelectionImplCopyWith<$Res> {
  __$$MultiSelectSelectionImplCopyWithImpl(_$MultiSelectSelectionImpl _value,
      $Res Function(_$MultiSelectSelectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$MultiSelectSelectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Id,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Title,
    ));
  }
}

/// @nodoc

class _$MultiSelectSelectionImpl implements _MultiSelectSelection {
  _$MultiSelectSelectionImpl(
      {@IdJsonConverter() required this.id,
      @TitleJsonConverter() required this.title});

  @override
  @IdJsonConverter()
  final Id id;
  @override
  @TitleJsonConverter()
  final Title title;

  @override
  String toString() {
    return 'MultiSelectSelection(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultiSelectSelectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MultiSelectSelectionImplCopyWith<_$MultiSelectSelectionImpl>
      get copyWith =>
          __$$MultiSelectSelectionImplCopyWithImpl<_$MultiSelectSelectionImpl>(
              this, _$identity);
}

abstract class _MultiSelectSelection implements MultiSelectSelection {
  factory _MultiSelectSelection(
          {@IdJsonConverter() required final Id id,
          @TitleJsonConverter() required final Title title}) =
      _$MultiSelectSelectionImpl;

  @override
  @IdJsonConverter()
  Id get id;
  @override
  @TitleJsonConverter()
  Title get title;
  @override
  @JsonKey(ignore: true)
  _$$MultiSelectSelectionImplCopyWith<_$MultiSelectSelectionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
