// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TermQuestion {
  @IdJsonConverter()
  Id get id => throw _privateConstructorUsedError;
  @TitleJsonConverter()
  Title get title => throw _privateConstructorUsedError;
  @TypeJsonConverter()
  Type get type =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'multi_selections')
  List<MultiSelectSelection> get multiSelections =>
      throw _privateConstructorUsedError;
  String? get answer => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TermQuestionCopyWith<TermQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermQuestionCopyWith<$Res> {
  factory $TermQuestionCopyWith(
          TermQuestion value, $Res Function(TermQuestion) then) =
      _$TermQuestionCopyWithImpl<$Res, TermQuestion>;
  @useResult
  $Res call(
      {@IdJsonConverter() Id id,
      @TitleJsonConverter() Title title,
      @TypeJsonConverter() Type type,
      @JsonKey(name: 'multi_selections')
      List<MultiSelectSelection> multiSelections,
      String? answer});

  $IdCopyWith<$Res> get id;
  $TitleCopyWith<$Res> get title;
  $TypeCopyWith<$Res> get type;
}

/// @nodoc
class _$TermQuestionCopyWithImpl<$Res, $Val extends TermQuestion>
    implements $TermQuestionCopyWith<$Res> {
  _$TermQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? multiSelections = null,
    Object? answer = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as Type,
      multiSelections: null == multiSelections
          ? _value.multiSelections
          : multiSelections // ignore: cast_nullable_to_non_nullable
              as List<MultiSelectSelection>,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
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

  @override
  @pragma('vm:prefer-inline')
  $TypeCopyWith<$Res> get type {
    return $TypeCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TermQuestionImplCopyWith<$Res>
    implements $TermQuestionCopyWith<$Res> {
  factory _$$TermQuestionImplCopyWith(
          _$TermQuestionImpl value, $Res Function(_$TermQuestionImpl) then) =
      __$$TermQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IdJsonConverter() Id id,
      @TitleJsonConverter() Title title,
      @TypeJsonConverter() Type type,
      @JsonKey(name: 'multi_selections')
      List<MultiSelectSelection> multiSelections,
      String? answer});

  @override
  $IdCopyWith<$Res> get id;
  @override
  $TitleCopyWith<$Res> get title;
  @override
  $TypeCopyWith<$Res> get type;
}

/// @nodoc
class __$$TermQuestionImplCopyWithImpl<$Res>
    extends _$TermQuestionCopyWithImpl<$Res, _$TermQuestionImpl>
    implements _$$TermQuestionImplCopyWith<$Res> {
  __$$TermQuestionImplCopyWithImpl(
      _$TermQuestionImpl _value, $Res Function(_$TermQuestionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? multiSelections = null,
    Object? answer = freezed,
  }) {
    return _then(_$TermQuestionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Id,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as Title,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as Type,
      multiSelections: null == multiSelections
          ? _value._multiSelections
          : multiSelections // ignore: cast_nullable_to_non_nullable
              as List<MultiSelectSelection>,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TermQuestionImpl implements _TermQuestion {
  _$TermQuestionImpl(
      {@IdJsonConverter() required this.id,
      @TitleJsonConverter() required this.title,
      @TypeJsonConverter() required this.type,
      @JsonKey(name: 'multi_selections')
      required final List<MultiSelectSelection> multiSelections,
      this.answer})
      : _multiSelections = multiSelections;

  @override
  @IdJsonConverter()
  final Id id;
  @override
  @TitleJsonConverter()
  final Title title;
  @override
  @TypeJsonConverter()
  final Type type;
// ignore: invalid_annotation_target
  final List<MultiSelectSelection> _multiSelections;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'multi_selections')
  List<MultiSelectSelection> get multiSelections {
    if (_multiSelections is EqualUnmodifiableListView) return _multiSelections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_multiSelections);
  }

  @override
  final String? answer;

  @override
  String toString() {
    return 'TermQuestion(id: $id, title: $title, type: $type, multiSelections: $multiSelections, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._multiSelections, _multiSelections) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, type,
      const DeepCollectionEquality().hash(_multiSelections), answer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TermQuestionImplCopyWith<_$TermQuestionImpl> get copyWith =>
      __$$TermQuestionImplCopyWithImpl<_$TermQuestionImpl>(this, _$identity);
}

abstract class _TermQuestion implements TermQuestion {
  factory _TermQuestion(
      {@IdJsonConverter() required final Id id,
      @TitleJsonConverter() required final Title title,
      @TypeJsonConverter() required final Type type,
      @JsonKey(name: 'multi_selections')
      required final List<MultiSelectSelection> multiSelections,
      final String? answer}) = _$TermQuestionImpl;

  @override
  @IdJsonConverter()
  Id get id;
  @override
  @TitleJsonConverter()
  Title get title;
  @override
  @TypeJsonConverter()
  Type get type;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'multi_selections')
  List<MultiSelectSelection> get multiSelections;
  @override
  String? get answer;
  @override
  @JsonKey(ignore: true)
  _$$TermQuestionImplCopyWith<_$TermQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
