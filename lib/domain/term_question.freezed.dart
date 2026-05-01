// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TermQuestion {

@IdJsonConverter() Id get id;@TitleJsonConverter() Title get title;@TypeJsonConverter() Type get type;// ignore: invalid_annotation_target
@JsonKey(name: 'multi_selections')@MultiSelectSelectionJsonConverter() List<MultiSelectSelection> get multiSelections; String? get answer;
/// Create a copy of TermQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TermQuestionCopyWith<TermQuestion> get copyWith => _$TermQuestionCopyWithImpl<TermQuestion>(this as TermQuestion, _$identity);

  /// Serializes this TermQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TermQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.multiSelections, multiSelections)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,const DeepCollectionEquality().hash(multiSelections),answer);

@override
String toString() {
  return 'TermQuestion(id: $id, title: $title, type: $type, multiSelections: $multiSelections, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $TermQuestionCopyWith<$Res>  {
  factory $TermQuestionCopyWith(TermQuestion value, $Res Function(TermQuestion) _then) = _$TermQuestionCopyWithImpl;
@useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title title,@TypeJsonConverter() Type type,@JsonKey(name: 'multi_selections')@MultiSelectSelectionJsonConverter() List<MultiSelectSelection> multiSelections, String? answer
});


$IdCopyWith<$Res> get id;$TitleCopyWith<$Res> get title;$TypeCopyWith<$Res> get type;

}
/// @nodoc
class _$TermQuestionCopyWithImpl<$Res>
    implements $TermQuestionCopyWith<$Res> {
  _$TermQuestionCopyWithImpl(this._self, this._then);

  final TermQuestion _self;
  final $Res Function(TermQuestion) _then;

/// Create a copy of TermQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? type = null,Object? multiSelections = null,Object? answer = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Title,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as Type,multiSelections: null == multiSelections ? _self.multiSelections : multiSelections // ignore: cast_nullable_to_non_nullable
as List<MultiSelectSelection>,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TermQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of TermQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get title {
  
  return $TitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of TermQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TypeCopyWith<$Res> get type {
  
  return $TypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}
}


/// Adds pattern-matching-related methods to [TermQuestion].
extension TermQuestionPatterns on TermQuestion {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TermQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TermQuestion() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TermQuestion value)  $default,){
final _that = this;
switch (_that) {
case _TermQuestion():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TermQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _TermQuestion() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @TypeJsonConverter()  Type type, @JsonKey(name: 'multi_selections')@MultiSelectSelectionJsonConverter()  List<MultiSelectSelection> multiSelections,  String? answer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TermQuestion() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.multiSelections,_that.answer);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @TypeJsonConverter()  Type type, @JsonKey(name: 'multi_selections')@MultiSelectSelectionJsonConverter()  List<MultiSelectSelection> multiSelections,  String? answer)  $default,) {final _that = this;
switch (_that) {
case _TermQuestion():
return $default(_that.id,_that.title,_that.type,_that.multiSelections,_that.answer);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @TypeJsonConverter()  Type type, @JsonKey(name: 'multi_selections')@MultiSelectSelectionJsonConverter()  List<MultiSelectSelection> multiSelections,  String? answer)?  $default,) {final _that = this;
switch (_that) {
case _TermQuestion() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.multiSelections,_that.answer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TermQuestion implements TermQuestion {
   _TermQuestion({@IdJsonConverter() required this.id, @TitleJsonConverter() required this.title, @TypeJsonConverter() required this.type, @JsonKey(name: 'multi_selections')@MultiSelectSelectionJsonConverter() required final  List<MultiSelectSelection> multiSelections, this.answer}): _multiSelections = multiSelections;
  factory _TermQuestion.fromJson(Map<String, dynamic> json) => _$TermQuestionFromJson(json);

@override@IdJsonConverter() final  Id id;
@override@TitleJsonConverter() final  Title title;
@override@TypeJsonConverter() final  Type type;
// ignore: invalid_annotation_target
 final  List<MultiSelectSelection> _multiSelections;
// ignore: invalid_annotation_target
@override@JsonKey(name: 'multi_selections')@MultiSelectSelectionJsonConverter() List<MultiSelectSelection> get multiSelections {
  if (_multiSelections is EqualUnmodifiableListView) return _multiSelections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_multiSelections);
}

@override final  String? answer;

/// Create a copy of TermQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TermQuestionCopyWith<_TermQuestion> get copyWith => __$TermQuestionCopyWithImpl<_TermQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TermQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TermQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._multiSelections, _multiSelections)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,const DeepCollectionEquality().hash(_multiSelections),answer);

@override
String toString() {
  return 'TermQuestion(id: $id, title: $title, type: $type, multiSelections: $multiSelections, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$TermQuestionCopyWith<$Res> implements $TermQuestionCopyWith<$Res> {
  factory _$TermQuestionCopyWith(_TermQuestion value, $Res Function(_TermQuestion) _then) = __$TermQuestionCopyWithImpl;
@override @useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title title,@TypeJsonConverter() Type type,@JsonKey(name: 'multi_selections')@MultiSelectSelectionJsonConverter() List<MultiSelectSelection> multiSelections, String? answer
});


@override $IdCopyWith<$Res> get id;@override $TitleCopyWith<$Res> get title;@override $TypeCopyWith<$Res> get type;

}
/// @nodoc
class __$TermQuestionCopyWithImpl<$Res>
    implements _$TermQuestionCopyWith<$Res> {
  __$TermQuestionCopyWithImpl(this._self, this._then);

  final _TermQuestion _self;
  final $Res Function(_TermQuestion) _then;

/// Create a copy of TermQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? type = null,Object? multiSelections = null,Object? answer = freezed,}) {
  return _then(_TermQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Title,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as Type,multiSelections: null == multiSelections ? _self._multiSelections : multiSelections // ignore: cast_nullable_to_non_nullable
as List<MultiSelectSelection>,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TermQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of TermQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get title {
  
  return $TitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of TermQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TypeCopyWith<$Res> get type {
  
  return $TypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}
}

// dart format on
