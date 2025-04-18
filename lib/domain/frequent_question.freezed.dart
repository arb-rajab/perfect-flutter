// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frequent_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FrequentQuestion {
  @IdJsonConverter()
  Id get id => throw _privateConstructorUsedError;
  @TitleJsonConverter()
  Title get title => throw _privateConstructorUsedError;
  @DescriptionJsonConverter()
  Description get description => throw _privateConstructorUsedError;

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FrequentQuestionCopyWith<FrequentQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrequentQuestionCopyWith<$Res> {
  factory $FrequentQuestionCopyWith(
          FrequentQuestion value, $Res Function(FrequentQuestion) then) =
      _$FrequentQuestionCopyWithImpl<$Res, FrequentQuestion>;
  @useResult
  $Res call(
      {@IdJsonConverter() Id id,
      @TitleJsonConverter() Title title,
      @DescriptionJsonConverter() Description description});

  $IdCopyWith<$Res> get id;
  $TitleCopyWith<$Res> get title;
  $DescriptionCopyWith<$Res> get description;
}

/// @nodoc
class _$FrequentQuestionCopyWithImpl<$Res, $Val extends FrequentQuestion>
    implements $FrequentQuestionCopyWith<$Res> {
  _$FrequentQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Description,
    ) as $Val);
  }

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IdCopyWith<$Res> get id {
    return $IdCopyWith<$Res>(_value.id, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TitleCopyWith<$Res> get title {
    return $TitleCopyWith<$Res>(_value.title, (value) {
      return _then(_value.copyWith(title: value) as $Val);
    });
  }

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DescriptionCopyWith<$Res> get description {
    return $DescriptionCopyWith<$Res>(_value.description, (value) {
      return _then(_value.copyWith(description: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FrequentQuestionImplCopyWith<$Res>
    implements $FrequentQuestionCopyWith<$Res> {
  factory _$$FrequentQuestionImplCopyWith(_$FrequentQuestionImpl value,
          $Res Function(_$FrequentQuestionImpl) then) =
      __$$FrequentQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IdJsonConverter() Id id,
      @TitleJsonConverter() Title title,
      @DescriptionJsonConverter() Description description});

  @override
  $IdCopyWith<$Res> get id;
  @override
  $TitleCopyWith<$Res> get title;
  @override
  $DescriptionCopyWith<$Res> get description;
}

/// @nodoc
class __$$FrequentQuestionImplCopyWithImpl<$Res>
    extends _$FrequentQuestionCopyWithImpl<$Res, _$FrequentQuestionImpl>
    implements _$$FrequentQuestionImplCopyWith<$Res> {
  __$$FrequentQuestionImplCopyWithImpl(_$FrequentQuestionImpl _value,
      $Res Function(_$FrequentQuestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_$FrequentQuestionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Id,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Title,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Description,
    ));
  }
}

/// @nodoc

class _$FrequentQuestionImpl implements _FrequentQuestion {
  _$FrequentQuestionImpl(
      {@IdJsonConverter() required this.id,
      @TitleJsonConverter() required this.title,
      @DescriptionJsonConverter() required this.description});

  @override
  @IdJsonConverter()
  final Id id;
  @override
  @TitleJsonConverter()
  final Title title;
  @override
  @DescriptionJsonConverter()
  final Description description;

  @override
  String toString() {
    return 'FrequentQuestion(id: $id, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrequentQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description);

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrequentQuestionImplCopyWith<_$FrequentQuestionImpl> get copyWith =>
      __$$FrequentQuestionImplCopyWithImpl<_$FrequentQuestionImpl>(
          this, _$identity);
}

abstract class _FrequentQuestion implements FrequentQuestion {
  factory _FrequentQuestion(
          {@IdJsonConverter() required final Id id,
          @TitleJsonConverter() required final Title title,
          @DescriptionJsonConverter() required final Description description}) =
      _$FrequentQuestionImpl;

  @override
  @IdJsonConverter()
  Id get id;
  @override
  @TitleJsonConverter()
  Title get title;
  @override
  @DescriptionJsonConverter()
  Description get description;

  /// Create a copy of FrequentQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrequentQuestionImplCopyWith<_$FrequentQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
