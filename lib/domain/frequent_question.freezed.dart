// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frequent_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FrequentQuestion {

@IdJsonConverter() Id get id;@TitleJsonConverter() Title get title;@DescriptionJsonConverter() Description get description;
/// Create a copy of FrequentQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrequentQuestionCopyWith<FrequentQuestion> get copyWith => _$FrequentQuestionCopyWithImpl<FrequentQuestion>(this as FrequentQuestion, _$identity);

  /// Serializes this FrequentQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FrequentQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description);

@override
String toString() {
  return 'FrequentQuestion(id: $id, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $FrequentQuestionCopyWith<$Res>  {
  factory $FrequentQuestionCopyWith(FrequentQuestion value, $Res Function(FrequentQuestion) _then) = _$FrequentQuestionCopyWithImpl;
@useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title title,@DescriptionJsonConverter() Description description
});


$IdCopyWith<$Res> get id;$TitleCopyWith<$Res> get title;$DescriptionCopyWith<$Res> get description;

}
/// @nodoc
class _$FrequentQuestionCopyWithImpl<$Res>
    implements $FrequentQuestionCopyWith<$Res> {
  _$FrequentQuestionCopyWithImpl(this._self, this._then);

  final FrequentQuestion _self;
  final $Res Function(FrequentQuestion) _then;

/// Create a copy of FrequentQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Title,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as Description,
  ));
}
/// Create a copy of FrequentQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of FrequentQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get title {
  
  return $TitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of FrequentQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DescriptionCopyWith<$Res> get description {
  
  return $DescriptionCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}


/// Adds pattern-matching-related methods to [FrequentQuestion].
extension FrequentQuestionPatterns on FrequentQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FrequentQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FrequentQuestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FrequentQuestion value)  $default,){
final _that = this;
switch (_that) {
case _FrequentQuestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FrequentQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _FrequentQuestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @DescriptionJsonConverter()  Description description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FrequentQuestion() when $default != null:
return $default(_that.id,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @DescriptionJsonConverter()  Description description)  $default,) {final _that = this;
switch (_that) {
case _FrequentQuestion():
return $default(_that.id,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdJsonConverter()  Id id, @TitleJsonConverter()  Title title, @DescriptionJsonConverter()  Description description)?  $default,) {final _that = this;
switch (_that) {
case _FrequentQuestion() when $default != null:
return $default(_that.id,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FrequentQuestion implements FrequentQuestion {
   _FrequentQuestion({@IdJsonConverter() required this.id, @TitleJsonConverter() required this.title, @DescriptionJsonConverter() required this.description});
  factory _FrequentQuestion.fromJson(Map<String, dynamic> json) => _$FrequentQuestionFromJson(json);

@override@IdJsonConverter() final  Id id;
@override@TitleJsonConverter() final  Title title;
@override@DescriptionJsonConverter() final  Description description;

/// Create a copy of FrequentQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FrequentQuestionCopyWith<_FrequentQuestion> get copyWith => __$FrequentQuestionCopyWithImpl<_FrequentQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FrequentQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FrequentQuestion&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description);

@override
String toString() {
  return 'FrequentQuestion(id: $id, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$FrequentQuestionCopyWith<$Res> implements $FrequentQuestionCopyWith<$Res> {
  factory _$FrequentQuestionCopyWith(_FrequentQuestion value, $Res Function(_FrequentQuestion) _then) = __$FrequentQuestionCopyWithImpl;
@override @useResult
$Res call({
@IdJsonConverter() Id id,@TitleJsonConverter() Title title,@DescriptionJsonConverter() Description description
});


@override $IdCopyWith<$Res> get id;@override $TitleCopyWith<$Res> get title;@override $DescriptionCopyWith<$Res> get description;

}
/// @nodoc
class __$FrequentQuestionCopyWithImpl<$Res>
    implements _$FrequentQuestionCopyWith<$Res> {
  __$FrequentQuestionCopyWithImpl(this._self, this._then);

  final _FrequentQuestion _self;
  final $Res Function(_FrequentQuestion) _then;

/// Create a copy of FrequentQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,}) {
  return _then(_FrequentQuestion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as Id,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Title,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as Description,
  ));
}

/// Create a copy of FrequentQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IdCopyWith<$Res> get id {
  
  return $IdCopyWith<$Res>(_self.id, (value) {
    return _then(_self.copyWith(id: value));
  });
}/// Create a copy of FrequentQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TitleCopyWith<$Res> get title {
  
  return $TitleCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of FrequentQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DescriptionCopyWith<$Res> get description {
  
  return $DescriptionCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}

// dart format on
